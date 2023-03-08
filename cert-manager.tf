resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
  depends_on = [digitalocean_kubernetes_cluster.kubernetes_cluster]
}

resource "helm_release" "cert-manager" {
  name  = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  namespace = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "createCustomResource"
    value = "true"
  }

  depends_on = [ kubernetes_namespace.cert-manager ]
}
