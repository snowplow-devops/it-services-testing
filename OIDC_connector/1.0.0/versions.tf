terraform {
  required_version = "1.4.6"

  backend "s3" {
    encrypt        = true
    bucket         = "snowplow-terraform-state-for-internal-folder"
    dynamodb_table = "snowplow-terraform-lock"
    region         = "eu-west-1"
    key            = "aws_sandbox_oidc_testing.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }

  }
}
provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::719197435995:role/TechOpsDeployment"
  }
}
locals {
  permissions_boundary = "arn:aws:iam::719197435995:policy/TechOpsAccountBoundary"
}