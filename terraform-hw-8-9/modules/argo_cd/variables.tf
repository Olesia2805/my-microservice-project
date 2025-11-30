variable "namespace" {
  description = "Namespace for Argo CD"
  type        = string
  default     = "argo-cd"
}

variable "helm_chart_repo_url" {
  description = "URL of the Helm chart repository for Argo CD"
  type        = string
}

variable "chart_version" {
  description = "Version of the Argo CD Helm chart"
  type        = string
  default     = "5.53.1"
}
