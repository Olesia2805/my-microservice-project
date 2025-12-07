data "kubernetes_service" "argo_cd_server" {
  metadata {
    name      = "argo-cd-server"
    namespace = var.namespace
  }

  depends_on = [helm_release.argo_cd]
}

output "argo_cd_server_hostname" {
  value = try(
    data.kubernetes_service.argo_cd_server.status[0].load_balancer[0].ingress[0].hostname,
    ""
  )
}
