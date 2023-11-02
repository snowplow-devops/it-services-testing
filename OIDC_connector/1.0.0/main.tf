module "github_actions_it_services_testing_repo" {
  source  = "../modules/github_oidc_role"
  
  role_name       = "github-actions-it-services-testing-repo"
  oidc_provider   = "https://token.actions.githubusercontent.com"
  repository      = "snowplow-devops/it-services-testing"
  policy_arn      = "arn:aws:iam::aws:policy/AdministratorAccess"
  session_duration = 3600
}
