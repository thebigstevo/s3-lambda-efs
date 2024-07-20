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
resource "aws_efs_mount_target" "efs_mt" {
  for_each = {
    for idx, subnet_id in tolist(var.public_subnet_ids) : idx => subnet_id
  }
  subnet_id = each.value # Access the value (subnet ID) from the loop


  security_groups = [var.efs_sg_id]
  file_system_id  = aws_efs_file_system.efs_vol.id

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
