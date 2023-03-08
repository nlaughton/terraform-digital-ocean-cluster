resource "helm_release" "cluster-issuer" {
  name = "cluster-issuer"
  chart = "./helm_charts/cluster-issuer"
  namespace = "cert-manager"
  set {
    name = "letsencrypt_email"
    value = "${var.letsencrypt_email}"
  }
  depends_on = [
    helm_release.cert-manager,
  ]
}
