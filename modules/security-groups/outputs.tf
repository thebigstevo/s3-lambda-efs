output "efs_security_group_ids" {
  value = aws_security_group.efs_sg.id
}

output "lambda_security_group_ids" {
  value = aws_security_group.lambda_sg.id
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}
