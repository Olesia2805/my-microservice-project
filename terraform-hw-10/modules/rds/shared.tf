locals {
  resource_name = var.name
  family_map = {
    "postgres"          = "postgres14"
    "mysql"             = "mysql8.0"
    "aurora-mysql"      = "aurora-mysql5.7"
    "aurora-postgresql" = "aurora-postgresql13"
    "aurora"            = "aurora-postgresql13"
  }

  param_family = lookup(local.family_map, var.engine, "postgres14")
}

# Subnet group
resource "aws_db_subnet_group" "this" {
  name       = "${local.resource_name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge({ Name = "${local.resource_name}-subnet-group" }, var.tags)
}

# Security group
resource "aws_security_group" "this" {
  name        = "${local.resource_name}-sg"
  description = "Security group for ${local.resource_name} DB"
  vpc_id      = var.vpc_id
  tags        = merge({ Name = "${local.resource_name}-sg" }, var.tags)
}

# Ingress rules
resource "aws_security_group_rule" "ingress_cidr" {
  count             = var.allowed_cidr != "" ? 1 : 0
  description       = "Allow DB access from allowed CIDR"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.allowed_cidr]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "ingress_from_sgs" {
  for_each                 = toset(var.security_group_ingress_from_sg_ids)
  description              = "Allow DB access from another SG"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = each.value
}

# Parameter group для одиночного RDS
resource "aws_db_parameter_group" "single" {
  count       = var.use_aurora ? 0 : 1
  name        = "${var.name}-paramgrp"
  family      = "postgres15"
  description = "Parameter group for ${local.resource_name} (${var.engine})"
  tags        = var.tags
  lifecycle {
    prevent_destroy = false
  }

  parameter {
    name         = "max_connections"
    value        = lookup(var.db_parameter_overrides, "max_connections", "200")
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "work_mem"
    value        = lookup(var.db_parameter_overrides, "work_mem", "4096")
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "log_statement"
    value        = lookup(var.db_parameter_overrides, "log_statement", "none")
    apply_method = "immediate"
  }
}

# Aurora cluster parameter group
resource "aws_rds_cluster_parameter_group" "aurora" {
  count       = var.use_aurora ? 1 : 0
  name        = "${local.resource_name}-aurora-paramgrp"
  family      = local.param_family
  description = "Aurora parameter group for ${local.resource_name}"
  tags        = var.tags

  dynamic "parameter" {
    for_each = merge({
      max_connections = lookup(var.db_parameter_overrides, "max_connections", "200")
      work_mem        = lookup(var.db_parameter_overrides, "work_mem", "4096")
      log_statement   = lookup(var.db_parameter_overrides, "log_statement", "none")
    }, {})
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = parameter.key == "log_statement" ? "immediate" : "pending-reboot"
    }
  }
}