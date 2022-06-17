variable "name" {
  description = "Name of the Elastic File System"
  type        = string
}

variable "filesystem_subdirectory" {
  description = "Subdirectory to perform actions as source or destination"
  type        = string
  default     = "/"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = null
}

variable "bucket_acl" {
  description = "ACL to apply to the S3 bucket"
  type        = string
  default     = "private"
}

variable "bucket_subdirectory" {
  description = "Subdirectory to perform actions as source or destination"
  type        = string
  default     = "/"
}

variable "security_group_name" {
  description = "Name of the Elastic File System security group mount targets"
  type        = string
  default     = null
}

variable "subnets" {
  description = "IDs of subnets to create EFS Mount Targets in"
  type        = list(string)
}

variable "subnet_arn" {
  description = "ARN of the subnet to use for the EFS Mount Target"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "Allow ingress traffic to EFS Mount Targets from specified CIDR blocks"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC for DataSync EFS Location Security Group"
  type        = string
}

variable "tags" {
  description = "A map of tags applied to resources"
  type        = map(string)
  default     = {}
}

locals {
  tags = merge(
    var.tags,
    {
      Module       = "terraform-aws-datasync-efs-s3"
      ModuleSource = "terraform-aws-datasync-efs-s3"
    },
  )
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
