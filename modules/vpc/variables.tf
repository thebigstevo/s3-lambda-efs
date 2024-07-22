variable "region" {
 type = string
}
  

variable "vpc_cidr" {
 type = string
}

variable "project_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "enable_dns_hostnames" {
  type = bool
  description = "Enable DNS hostnames"
}

variable "enable_dns_support" {
  type = bool
  description = "Enable DNS support"
}
variable "map_public_ip_on_launch" {
  type = bool
  description = "map public ip on launch"
}
