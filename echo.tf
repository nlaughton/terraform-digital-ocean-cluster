resource "kubernetes_namespace" "echo" {
  metadata {
    name = "echo"
  }
  depends_on = [digitalocean_kubernetes_cluster.kubernetes_cluster]
}

resource "kubernetes_service" "service" {
  metadata {
    name = "echo"
    namespace = "echo"
  }
  spec {
    selector = {
      app = "echo"
    }
    port {
      port = 80
      target_port = 5678
    }
  }
  depends_on = [
    kubernetes_namespace.echo]
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "echo"
    namespace = "echo"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "echo"
      }
    }
    template {
      metadata {
        labels = {
          app = "echo"
        }
      }
      spec {
        container {
          name = "echo"
          image = "hashicorp/http-echo"
          args = [
            "-text=echo"]
          port {
            container_port = 5678
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_namespace.echo]
}

resource "kubernetes_ingress_v1" "ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "echo"
    namespace = "echo"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
      "service.beta.kubernetes.io/do-loadbalancer-name":var.domain
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "echo.${var.domain}"
      http {
        path {
          path = "/"
          backend {
            service {
              name = "echo"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
    tls {
      secret_name = "echo-tls"
      hosts = [
        "echo.${var.domain}"]

    }
  }
  depends_on = [
    helm_release.ingress-nginx,
    kubernetes_namespace.echo
  ]
}

resource "digitalocean_record" "subdomain" {

  domain = var.domain
  type = "A"
  name = "echo"
  value = kubernetes_ingress_v1.ingress.status[0].load_balancer[0].ingress[0].ip

  depends_on = [
    kubernetes_ingress_v1.ingress]
}

