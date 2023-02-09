output "externaldns_helm_metadata"  { value = helm_release.external_dns.metadata        }
output "externaldns_iam_policy_arn" { value = aws_iam_policy.externaldns_iam_policy.arn }
output "externaldns_iam_role_arn"   { value = aws_iam_role.externaldns_iam_role.arn     }