# Select a random subnet from the list of public subnets
locals {
  random_subnet_id = element(var.public_subnet_ids, 0)
}

# EC2 Instance
resource "aws_instance" "test_server" {
  ami                         = var.ami_id #Amazon Linux 2023 AMI 2023.5.20240708.0 x86_64 HVM kernel-6.1
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = local.random_subnet_id
  security_groups             = [var.ec2_security_group_ids]
  # EBS Block Device Mapping
  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }
  user_data = <<EOF
  #!/bin/bash
  sudo mkdir efs
  sudo yum install -y amazon-efs-utils
  sudo mount -t efs -o tls,accesspoint=fsap-042d50429dc0cb051 fs-07e61a24fc4e3e043:/ efs
  EOF

}
