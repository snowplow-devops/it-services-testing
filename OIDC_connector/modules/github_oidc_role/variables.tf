variable "role_name" {
  description = "The name of the IAM role."
  type        = string
}

variable "oidc_provider" {
  description = "The URL of the OIDC provider."
  type        = string
}

variable "repository" {
  description = "The GitHub repository with the format owner/name."
  type        = string
}

variable "policy_arn" {
  description = "The ARN of the policy to attach to the role."
  type        = string
}

variable "session_duration" {
  description = "The maximum session duration for the role."
  type        = number
  default     = 3600
}

variable "permissions_boundary" {
  description = "The ARN of the permissions boundary to attach to the role."
  type        = string
  default     = "arn:aws:iam::719197435995:policy/TechOpsAccountBoundary"
}
