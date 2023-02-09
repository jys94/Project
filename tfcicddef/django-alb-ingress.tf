# resource "kubernetes_ingress_v1" "web-ingress" {
#   metadata {
#     name = "web-alb-ingress"
#     annotations = {
#       ## Core Settings
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"  # ExternalLB (or InternalLB)
#       "alb.ingress.kubernetes.io/target-type" = "instance"  # Target Group's Target Type
#       "alb.ingress.kubernetes.io/load-balancer-name" = "eks-alb-ingress"  # Load Balancer Name
#       ## Health Check Settings
#       "alb.ingress.kubernetes.io/healthcheck-protocol" =  "HTTP"
#       "alb.ingress.kubernetes.io/healthcheck-port" = "traffic-port"
#       "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
#       "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = 5
#       "alb.ingress.kubernetes.io/success-codes" = 200
#       "alb.ingress.kubernetes.io/healthy-threshold-count" = 2
#       "alb.ingress.kubernetes.io/unhealthy-threshold-count" = 2
#       ## SSL Settings
#       "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{"HTTPS" = 443}, {"HTTP" = 80}])
#       ## SSL Redirect Setting
#       "alb.ingress.kubernetes.io/ssl-redirect" = 443
#       ## Ingress Groups
#       "alb.ingress.kubernetes.io/group.name" = "web-infra"
#       "alb.ingress.kubernetes.io/group.order" = 10
#     }    
#   }
#   spec {
#     rule {
#       host = "www.lishprj.link"
#       http {
#         path {
#           path_type = "Prefix"
#           path = "/"
#           backend {
#             service {
#               name = "nginx-np"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }        
#     }
#   }
# }