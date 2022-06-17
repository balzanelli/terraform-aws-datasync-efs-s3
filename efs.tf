locals {
  security_group_name = var.security_group_name != null ? var.security_group_name : var.name
}

resource "aws_efs_file_system" "this" {
  creation_token = var.name

  tags = merge(
    local.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_security_group" "this" {
  name        = local.security_group_name
  description = "Security Group for Elastic File System ${var.name}"
  vpc_id      = var.vpc_id

  tags = merge(
    local.tags,
    {
      Name = var.name
    },
  )
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.this.id
  description       = "Allow inbound SFTP traffic from CIDR blocks"
  type              = "ingress"
  cidr_blocks       = var.ingress_cidr_blocks
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.this.id
  description       = "Allow all outbound traffic to the internet"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
}

resource "aws_efs_mount_target" "this" {
  count = length(var.subnets)

  file_system_id  = aws_efs_file_system.this.id
  security_groups = [aws_security_group.this.id]
  subnet_id       = var.subnets[count.index]
}
