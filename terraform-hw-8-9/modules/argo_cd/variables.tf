variable "kubeconfig" {
  description = "Шлях до kubeconfig файлу EKS"
  type        = string
}

variable "cluster_name" {
  description = "Назва кластера EKS"
  type        = string
}

variable "helm_chart_repo_url" {
  description = "URL Git репозиторію, що містить Helm-чарт Django-застосунку"
  type        = string
}