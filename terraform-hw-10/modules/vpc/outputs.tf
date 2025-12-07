output "vpc_id" {
  description = "ID створеної VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "Список ID публічних підмереж"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnets" {
  description = "Список ID приватних підмереж"
  value       = [for subnet in aws_subnet.private : subnet.id]
}
