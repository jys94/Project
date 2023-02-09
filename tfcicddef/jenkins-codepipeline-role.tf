# # Create IAM Role
# resource "aws_iam_role" "jenkins_codepipeline_polling_iam_role" {
#   name = "jenkins-codepipeline-polling-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Federated = "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn}"
#         }
#         Condition = {
#           StringEquals = {
#             "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:default:jenkins"
#           }
#         }        
#       },
#     ]
#   })
# }

# # Associate IAM Policy to IAM Role
# resource "aws_iam_role_policy_attachment" "cluster_autoscaler_iam_role_policy_attach" {
#   policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineCustomActionAccess"
#   role       = aws_iam_role.jenkins_codepipeline_polling_iam_role.name
# }