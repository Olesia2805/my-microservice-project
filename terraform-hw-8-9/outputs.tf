# S3 backend
output "s3_bucket_name" {
  value = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  value = module.s3_backend.dynamodb_table_name
}

# VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

# ECR
output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "ecr_repository_arn" {
  value = module.ecr.repository_arn
}

output "ecr_repository_name" {
  value = module.ecr.repository_name
}

# Jenkins (виводимо те, що повернув модуль jenkins)
output "jenkins_service_hostname" {
  description = "LoadBalancer hostname for Jenkins service (if any)"
  value       = try(module.jenkins.jenkins_service_hostname, "")
}

output "jenkins_namespace" {
  value = try(module.jenkins.jenkins_namespace, "jenkins")
}

output "argocd_service_hostname" {
  value = try(module.argo_cd.argocd_service_hostname, "")
}
