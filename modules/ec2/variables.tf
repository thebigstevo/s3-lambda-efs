variable "instance_type" {
  type        = string
  description = "Instance Types"
}

variable "ec2_security_group_ids" {
  type        = string
  description = "Security group ID"
}

variable "ami_id" {
  type        = string
  description = "AMI ID"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of IDs for created subnets"
}

variable "efs_access_point_id" {
  
}

variable "efs_file_system_id" {
  
}