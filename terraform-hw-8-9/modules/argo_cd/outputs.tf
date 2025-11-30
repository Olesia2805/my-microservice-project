output "argocd_hostname" {
  description = "URL для доступу до Argo CD (LoadBalancer Hostname)"
  # NOTE: Використовуйте реальні дані з ресурсу LoadBalancer
  value       = "http://<ArgoCD-LoadBalancer-Hostname>:80" 
}