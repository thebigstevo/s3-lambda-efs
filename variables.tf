variable "vpc_id" {

}

variable "vpc_name" {

}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "project_name" {
  default = "s3tolambdatoefs"
}

variable "availability-zone-1" {
  default = "eu-west-1a"
}

variable "availability-zone-2" {
  default = "eu-west-1b"
}

variable "availability-zone-3" {
  default = "eu-west-1c"
}

variable "subnet-1-cidr" {
  default = "10.0.1.0/24"
}

variable "subnet-2-cidr" {
  default = "10.0.2.0/24"
}

variable "subnet-3-cidr" {
  default = "10.0.3.0/24"
}
