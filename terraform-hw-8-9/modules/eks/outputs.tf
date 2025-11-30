output "eks_cluster_endpoint" {
  description = "EKS API endpoint for connecting to the cluster"
  value       = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "eks_cluster_token" {
  value = data.aws_eks_cluster_auth.eks.token
}


output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eks.name
}

output "cluster_arn" {
  description = "ARN EKS кластера"
  value       = aws_eks_cluster.eks.arn
}

output "node_group_name" {
  description = "Назва Node Group"
  value       = aws_eks_node_group.nodes.node_group_name
}

output "node_role_arn" {
  description = "ARN IAM-ролі Node Group"
  value       = aws_iam_role.eks_nodes.arn
}

output "kubeconfig" {
  value = local.kubeconfig_file
}