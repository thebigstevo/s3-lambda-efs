variable "vpc_id" {

}

variable "vpc_name" {

}
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
  default = "t2-micro"
}

variable "ami_id" {
  default = "ami-0b995c42184e99f98"
}