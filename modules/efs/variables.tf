variable "region" {
  description="Default region"
  type = string
}


variable "vpc_cidr" {
description = "CIDR Block for VPC"
type = string
}

variable "project_name" {
  description = "Project Name"
  type = string
}

variable "public_subnet_ids" {
  description = "List of subnet IDs"
  type = list(string)

}
variable "efs_sg_id" {
  description = "ID of security group for EFS access"
type = string

}