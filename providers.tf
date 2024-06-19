#configure required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#configure the AWS provider
provider "aws" {
  region = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
