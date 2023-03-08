resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
  depends_on = [digitalocean_kubernetes_cluster.kubernetes_cluster]
}

resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  namespace = "default"

  set {
    name = "service.type"
    value = "LoadBalancer"
  }
  depends_on = [
    kubernetes_namespace.ingress-nginx]

}
