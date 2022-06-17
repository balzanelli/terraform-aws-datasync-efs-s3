variable "region" {
  description = "AWS region"
  type        = string
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
