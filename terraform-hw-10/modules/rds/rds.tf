# Single RDS instance
resource "aws_db_instance" "single" {
  count                  = var.use_aurora ? 0 : 1
  identifier             = "${var.name}-instance"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  skip_final_snapshot    = true
  publicly_accessible    = var.publicly_accessible
  parameter_group_name   = try(aws_db_parameter_group.single[0].name, null)
  apply_immediately      = true
  storage_encrypted      = var.storage_encrypted
  backup_retention_period = var.backup_retention_period
  allocated_storage       = 20
  tags                   = var.tags
}