output "efs_access_point_arn" {
  value = aws_efs_access_point.efs_ap.arn
}

output "efs_access_point_id" {
  value = aws_efs_access_point.efs_ap.id
}

output "aws_efs_file_system_id" {
  value = aws_efs_file_system.efs_vol.id
}