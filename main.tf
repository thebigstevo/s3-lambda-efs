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
}

terraform {
  backend "remote" {
    organization = "bigspark"

    workspaces {
      name = "s3-lambda-efs"
    }
  }
}
data "aws_vpc" "myvpc" {
    id= "vpc-0e6c3c7402f44285d"
  
}
resource "aws_s3_bucket" "receiving_bucket" {
  bucket= "sle24-bucket"
}

resource "aws_efs_file_system" "efs_vol" {
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

resource "aws_security_group" "efs_sg" {
  name_prefix = "efs_sg"
    vpc_id = data.aws_vpc.myvpc.id
}