variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubeconfig" {
  description = "Kubernetes access configuration"
  type        = string
}
