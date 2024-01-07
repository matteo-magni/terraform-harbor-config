terraform {
  required_version = ">=1.0.0"

  required_providers {
    harbor = {
      source  = "goharbor/harbor"
      version = ">=3.10.6"
    }
  }
}

provider "harbor" {
  url         = var.auth.url
  username    = var.auth.username
  password    = var.auth.password
  insecure    = var.auth.insecure
  api_version = var.auth.api_version
}
