#EFS file system
resource "aws_efs_file_system" "efs_vol" {
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

#commented below for later
# resource "aws_efs_mount_target" "efs_mt" {
#   for_each = toset(data.aws_subnets.my_subnets.*.id)

#   file_system_id  = aws_efs_file_system.efs_vol.id
#   subnet_id       = each.value
#   security_groups = [aws_security_group.efs_sg.id]
# }

resource "aws_efs_access_point" "efs_ap" {
  file_system_id = aws_efs_file_system.efs_vol.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/"

    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }
}