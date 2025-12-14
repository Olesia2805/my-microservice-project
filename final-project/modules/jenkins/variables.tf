variable "namespace" {
  description = "Kubernetes namespace where Jenkins will be deployed"
  type        = string
  default     = "jenkins"
}

variable "chart_version" {
  description = "Helm chart version for Jenkins"
  type        = string
  default     = "5.8.110"
}
