variable "digital_ocean_token" {
  description = "The DigitalOcean token which determines which team the cluster is created in."
  sensitive = true
}

variable domain {
  description = "Top level domain that will be related to this cluster (example.com)."
  type = string
}

variable region {
  description = "The DigitalOcean region that the cluster should be created in (NYC1 for example)."
  type = string
}

variable letsencrypt_email {
  description = "The email address that will be used when setting up letsencrypt (enter your email)."
  type = string
}
