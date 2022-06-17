provider "aws" {
  region = var.region
}

resource "random_id" "bucket_id" {
  byte_length = 8
}

module "efs" {
  source = "../../"

  name        = "datasync-efs-s3-simple"
  bucket_name = "datasync-efs-s3-simple-${random_id.bucket_id.hex}"

  subnets             = var.subnets
  subnet_arn          = var.subnet_arn
  ingress_cidr_blocks = var.ingress_cidr_blocks
  vpc_id              = var.vpc_id
}
