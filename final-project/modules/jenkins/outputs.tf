output "jenkins_namespace" {
  description = "Namespace where Jenkins is deployed"
  value       = kubernetes_namespace.jenkins.metadata[0].name
}

output "jenkins_service_hostname" {
  description = "External hostname of Jenkins LoadBalancer"
  value = try(
    data.kubernetes_service.jenkins_service.status[0].load_balancer[0].ingress[0].hostname,
    ""
  )
}

output "jenkins_service_ip" {
  description = "External IP (if AWS allocated IP instead of hostname)"
  value = try(
    data.kubernetes_service.jenkins_service.status[0].load_balancer[0].ingress[0].ip,
    ""
  )
}
