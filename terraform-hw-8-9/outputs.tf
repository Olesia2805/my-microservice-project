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

# Jenkins
output "jenkins_release" {
  value = module.jenkins.jenkins_release_name
}

output "jenkins_namespace" {
  value = module.jenkins.jenkins_namespace
}

# Argo CD
output "argo_cd_server_url" {
  value = "https://argo-cd.argo-cd.svc.cluster.local"
}

output "argo_cd_initial_admin_password" {
  value = "admin"
}