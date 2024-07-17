# S3 bucket
resource "aws_s3_bucket" "receiving_bucket" {
  bucket        = "sle24-bucket"
  force_destroy = true
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id     = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = [var.route_table_id]

  tags = {
    Name = "${var.project_name}-s3-endpoint"
  }
}



