resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name = "promgraf-alb-ingress"
    annotations = {
      ## Core Settings
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"  # ExternalLB (or InternalLB)
      "alb.ingress.kubernetes.io/target-type" = "instance"  # Target Group's Target Type
      "alb.ingress.kubernetes.io/load-balancer-name" = "eks-alb-ingress"  # Load Balancer Name
      ## Health Check Settings
      "alb.ingress.kubernetes.io/healthcheck-protocol" =  "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-port" = "traffic-port"
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = 5
      "alb.ingress.kubernetes.io/success-codes" = 200
      "alb.ingress.kubernetes.io/healthy-threshold-count" = 2
      "alb.ingress.kubernetes.io/unhealthy-threshold-count" = 2
      ## SSL Settings
      "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{"HTTPS" = 443}, {"HTTP" = 80}])
      ## SSL Redirect Setting
      "alb.ingress.kubernetes.io/ssl-redirect" = 443
      ## Ingress Groups
      "alb.ingress.kubernetes.io/group.name" = "web-infra"
      "alb.ingress.kubernetes.io/group.order" = 30
    }    
  }
  spec {
    rule { # Prometheus Server Routing Rule
      host = "prom.${data.terraform_remote_state.addons.outputs.aws_route53_zone_name}" # host = "prom.lishprj.link"
      http {
        path {
          path_type = "Prefix"
          path = "/"
          backend {
            service {
              name = "prometheus-server"
              port {
                number = 80
              }
            }
          }
        }
      }        
    }
    rule { # Grafana Routing Rule
      host = "graf.${data.terraform_remote_state.addons.outputs.aws_route53_zone_name}" # host = "graf.lishprj.link"
      http {
        path {
          path_type = "Prefix"
          path = "/"
          backend {
            service {
              name = "grafana"
              port {
                number = 80
              }
            }
          }
        }
      }        
    }
    rule { # Prometheus AlertManager Routing Rule
      host = "promalert.${data.terraform_remote_state.addons.outputs.aws_route53_zone_name}" # host = "promalert.lishprj.link"
      http {
        path {
          path_type = "Prefix"
          path = "/"
          backend {
            service {
              name = "prometheus-alertmanager"
              port {
                number = 80
              }
            }
          }
        }
      }        
    }
  }
}