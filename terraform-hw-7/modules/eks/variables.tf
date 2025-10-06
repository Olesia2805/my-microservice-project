variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "example-eks-cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
