resource "kubernetes_ingress_v1" "elasticsearch_ingress" {
  metadata {
    name = "elasticsearch-alb-ingress"
    annotations = {
      ## Core Settings
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"  # ExternalLB (or InternalLB)
      "alb.ingress.kubernetes.io/target-type" = "ip"  # Target Group's Target Type
      "alb.ingress.kubernetes.io/load-balancer-name" = "eks-alb-ingress"  # Load Balancer Name
      ## SSL Settings
      "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{"HTTPS" = 443}, {"HTTP" = 80}])
      ## SSL Redirect Setting
      "alb.ingress.kubernetes.io/ssl-redirect" = 443
      ## Ingress Groups
      "alb.ingress.kubernetes.io/group.name" = "web-infra"
      "alb.ingress.kubernetes.io/group.order" = 60
      ## HTTPS Backend Protocol Setting
      "alb.ingress.kubernetes.io/backend-protocol" = "HTTPS"
    }    
  }
  spec {
    rule { # Elasticsearch Routing Rule
      host = "elastic.${data.terraform_remote_state.addons.outputs.aws_route53_zone_name}" # host = "elastic.lishprj.link"
      http {
        path {
          path_type = "Prefix"
          path = "/"
          backend {
            service {
              name = "elasticsearch-master"
              port {
                number = 9200
              }
            }
          }
        }
      }
    }
  }
}