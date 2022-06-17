data "aws_iam_policy_document" "bucket_access_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["datasync.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "bucket_access" {
  name               = "${var.name}-bucket-access-role"
  assume_role_policy = data.aws_iam_policy_document.bucket_access_assume_role.json

  tags = local.tags
}

data "aws_iam_policy_document" "bucket_access" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [aws_s3_bucket.this.arn]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListMultipartUploadParts",
      "s3:GetObjectTagging"
    ]
    resources = ["${aws_s3_bucket.this.arn}/*"]
  }
}

resource "aws_iam_role_policy" "bucket_access" {
  name   = "${var.name}-bucket-access-role-policy"
  role   = aws_iam_role.bucket_access.id
  policy = data.aws_iam_policy_document.bucket_access.json
}

resource "aws_datasync_location_s3" "this" {
  s3_bucket_arn = aws_s3_bucket.this.arn
  subdirectory  = var.bucket_subdirectory

  s3_config {
    bucket_access_role_arn = aws_iam_role.bucket_access.arn
  }

  tags = local.tags
}

resource "aws_datasync_location_efs" "this" {
  efs_file_system_arn = aws_efs_mount_target.this[0].file_system_arn
  subdirectory        = var.filesystem_subdirectory

  ec2_config {
    security_group_arns = [aws_security_group.this.arn]
    subnet_arn          = var.subnet_arn
  }

  tags = local.tags
}

resource "aws_datasync_task" "this" {
  name                     = var.name
  source_location_arn      = aws_datasync_location_s3.this.arn
  destination_location_arn = aws_datasync_location_efs.this.arn

  tags = local.tags
}
