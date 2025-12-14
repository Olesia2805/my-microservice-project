# Aurora cluster
resource "aws_rds_cluster" "aurora" {
  count                 = var.use_aurora ? 1 : 0
  cluster_identifier    = "${var.name}-cluster"
  engine                = "aurora-postgresql"
  engine_version        = var.engine_version
  master_username       = var.username
  master_password       = var.password
  database_name         = var.db_name
  db_subnet_group_name  = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot   = true
  tags                  = var.tags
}

# Aurora cluster instance
resource "aws_rds_cluster_instance" "aurora_instance" {
  count               = var.use_aurora ? 1 : 0
  identifier          = "${var.name}-cluster-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.aurora[0].id
  instance_class      = var.instance_class
  engine              = "aurora-postgresql"
  engine_version      = var.engine_version
  publicly_accessible = var.publicly_accessible
}