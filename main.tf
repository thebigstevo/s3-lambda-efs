data "aws_vpc" "myvpc" {
  id = "vpc-0e6c3c7402f44285d"

}
resource "aws_s3_bucket" "receiving_bucket" {
  bucket = "sle24-bucket"
}




