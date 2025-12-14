output "endpoint" {
  value = var.use_aurora ? try(aws_rds_cluster.aurora[0].endpoint, null) : try(aws_db_instance.single[0].address, null)
}

output "port" {
  value = var.use_aurora ? try(aws_rds_cluster.aurora[0].port, 5432) : try(aws_db_instance.single[0].port, 5432)
}

output "db_instance_id" {
  value = var.use_aurora ? try(aws_rds_cluster.aurora[0].id, null) : try(aws_db_instance.single[0].id, null)
}
