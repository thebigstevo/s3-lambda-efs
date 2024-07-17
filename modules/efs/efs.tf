#EFS file system
resource "aws_efs_file_system" "efs_vol" {
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name = "${var.project_name}-file-system"
  }
}


# EFS mount targets
resource "aws_efs_mount_target" "efs_mt-1" {
  file_system_id  = aws_efs_file_system.efs_vol.id
  subnet_id       = var.public_subnet_1_id
  security_groups = [var.efs_sg_id ]
}

resource "aws_efs_mount_target" "efs_mt-2" {
  file_system_id  = aws_efs_file_system.efs_vol.id
  subnet_id       = var.public_subnet_2_id
  security_groups = [var.efs_sg_id ]
}

resource "aws_efs_mount_target" "efs_mt-3" {
  file_system_id  = aws_efs_file_system.efs_vol.id
  subnet_id       = var.public_subnet_3_id
  security_groups = [var.efs_sg_id ]
}

# EFS access point
resource "aws_efs_access_point" "efs_ap" {
  file_system_id = aws_efs_file_system.efs_vol.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/efs"

    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }

  tags = {
    Name = "s3tolto-efs-access-point"
  }
}