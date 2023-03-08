terraform {
  required_providers {

    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = ">= 2.0.1"
    }

    auth0 = {
      source = "auth0/auth0"
      version = "~> 0.40.0"
    }

    sendgrid = {
      source = "Trois-Six/sendgrid"
      version = "0.2.1"
    }

  }

  required_version = ">= 1.3.3"
}
