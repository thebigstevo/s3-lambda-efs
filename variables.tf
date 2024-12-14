# variable "vpc_id" {

# }

# variable "vpc_name" {

# }
variable "region" {
  default = "eu-west-1"
}


variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "project_name" {
  default = "s3tolambdatoefs"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0b995c42184e99f98"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support"
  default     = true
}
variable "map_public_ip_on_launch" {
  type        = bool
  description = "map public ip on launch"
  default     = true
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
