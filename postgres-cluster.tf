resource "digitalocean_database_cluster" "postgres_cluster" {
  name       = replace(var.domain,".","-")
  engine     = "pg"
  version    = "14"
  size       = "db-s-1vcpu-1gb"
  region     =  upper(var.region)
  node_count = 1
}

resource "digitalocean_database_firewall" "postgres_firewall" {
  cluster_id = digitalocean_database_cluster.postgres_cluster.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.kubernetes_cluster.id
  }

  depends_on = [digitalocean_database_cluster.postgres_cluster,digitalocean_kubernetes_cluster.kubernetes_cluster]
}

