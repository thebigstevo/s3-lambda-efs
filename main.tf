data "aws_vpc" "myvpc" {
    id= "vpc-0a9cd782fa83afa83"
  
}
resource "aws_s3_bucket" "receiving_bucket" {
  bucket= "sle24-bucket"
}

# resource "aws_efs_file_system" "efs_vol" {
#   lifecycle_policy {
#     transition_to_ia = "AFTER_30_DAYS"
#   }
# }

# resource "aws_security_group" "efs_sg" {
#   name_prefix = "efs_sg"
#     vpc_id = data.aws_vpc.myvpc.id
# }