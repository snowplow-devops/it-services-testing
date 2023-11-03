module "github_actions_it_services_testing_repo" {
  source  = "../modules/github_oidc_role"
  
  role_name       = "github-actions-it-services-testing-repo"
  oidc_provider   = "https://token.actions.githubusercontent.com"
  repository      = "snowplow-devops/it-services-testing"
  policy_arn      = aws_iam_policy.github_actions_it_services_testing_repo.arn
  session_duration = 3600
}

resource aws_iam_policy "github_actions_it_services_testing_repo" {
  name        = "github-actions-it-services-testing-repo"
  description = "IAM policy for GitHub Actions in the it-services-testing repo"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "*",
        Resource = "*"
      }
    ]
  })
}


# data "aws_iam_openid_connect_provider" "github_oidc" {
#   url = "https://token.actions.githubusercontent.com"
# }

# output "connector" {
#   value = data.aws_iam_openid_connect_provider.github_oidc.thumbprint_list
# }