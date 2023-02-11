resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name = "kibana-alb-ingress"
    # namespace = "kube-system"
    annotations = {
      ## Core Settings
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"  # ExternalLB (or InternalLB)
      "alb.ingress.kubernetes.io/target-type" = "instance"  # Target Group's Target Type
      "alb.ingress.kubernetes.io/load-balancer-name" = "eks-alb-ingress"  # Load Balancer Name
      ## SSL Settings
      "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{"HTTPS" = 443}, {"HTTP" = 80}])
      ## SSL Redirect Setting
      "alb.ingress.kubernetes.io/ssl-redirect" = 443
      ## Ingress Groups
      "alb.ingress.kubernetes.io/group.name" = "web-infra"
      "alb.ingress.kubernetes.io/group.order" = 60
    }    
  }
  spec {
    rule { # Kibana Routing Rule
      host = "kibana.${data.terraform_remote_state.addons.outputs.aws_route53_zone_name}" # host = "kibana.lishprj.link"
      http {
        path {
          path_type = "Prefix"
          path = "/"
          backend {
            service {
              name = "kibana-kibana"
              port {
                number = 5601
              }
            }
          }
        }
      }        
    }
  }
}