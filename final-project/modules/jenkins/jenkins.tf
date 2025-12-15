# -------------------------
# Namespace
# -------------------------
resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}

# -------------------------
# Jenkins Helm Release
# -------------------------
resource "helm_release" "jenkins" {
  name       = "jenkins"
  namespace  = kubernetes_namespace.jenkins.metadata[0].name
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  depends_on = [
    kubernetes_namespace.jenkins
  ]
}

# -------------------------
# LoadBalancer Service Info
# -------------------------
data "kubernetes_service" "jenkins_service" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace.jenkins.metadata[0].name
  }

  depends_on = [helm_release.jenkins]
}
