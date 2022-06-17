output "efs_file_system_id" {
  value = aws_efs_file_system.this.id
}

output "efs_file_system_arn" {
  value = aws_efs_file_system.this.arn
}

output "efs_file_system_creation_token" {
  value = aws_efs_file_system.this.creation_token
}

output "s3_bucket_id" {
  value = aws_s3_bucket.this.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.this.arn
}
