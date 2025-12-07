output "repository_url" {
  description = "URL створеного репозиторію ECR"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "ARN створеного репозиторію ECR"
  value       = aws_ecr_repository.this.arn
}

output "repository_name" {
  description = "Ім'я створеного репозиторію ECR"
  value       = aws_ecr_repository.this.name
}