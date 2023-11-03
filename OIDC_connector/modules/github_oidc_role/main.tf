# # Fetch information about the OIDC provider dynamically
# data "aws_iam_openid_connect_provider" "github_oidc" {
#   url = var.oidc_provider
# }

# IAM Role for GitHub Actions
resource "aws_iam_role" "github_actions_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::719197435995:oidc-provider/${var.oidc_provider}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${var.oidc_provider}:aud" = "sts.amazonaws.com"
          },
          StringLike = {
            "${var.oidc_provider}:sub" = "repo:${var.repository}:*"
          }
        }
      }
    ]
  })

  max_session_duration = var.session_duration
  permissions_boundary = var.permissions_boundary
}

# IAM Policy Attachment for the IAM Role
resource "aws_iam_policy_attachment" "admin_access" {
  name       = "${var.role_name}-access-attachment"
  roles      = [aws_iam_role.github_actions_role.name]
  policy_arn = var.policy_arn
}

# OpenID Connect Provider using the dynamically retrieved thumbprint
resource "aws_iam_openid_connect_provider" "github_oidc" {
  url             = var.oidc_provider
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
  //data.aws_iam_openid_connect_provider.github_oidc.thumbprint_list

  tags = {
    repo = split("/", var.repository)[1]
  }
}
