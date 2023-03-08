
resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name       = replace(var.domain,".","-")
  region  = var.region
  version = "1.24.8-do.0"

  node_pool {
    name       = "autoscale-worker-pool"
    size       = "s-2vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
  }
}
