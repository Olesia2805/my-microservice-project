output "jenkins_url" {
  description = "URL для доступу до Jenkins (LoadBalancer Hostname)"
  # NOTE: Використовуйте реальні дані з ресурсу LoadBalancer
  value       = "http://<Jenkins-LoadBalancer-Hostname>:8080" 
}