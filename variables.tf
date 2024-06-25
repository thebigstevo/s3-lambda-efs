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