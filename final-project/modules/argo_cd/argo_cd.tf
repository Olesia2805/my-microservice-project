resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  namespace  = kubernetes_namespace.argo_cd.metadata[0].name
  repository = var.helm_chart_repo_url
  chart      = "argo-cd"
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  depends_on = [kubernetes_namespace.argo_cd]
}
