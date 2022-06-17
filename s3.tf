locals {
  bucket_name = var.bucket_name != null ? var.bucket_name : var.name
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags   = local.tags
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.bucket_acl
}
