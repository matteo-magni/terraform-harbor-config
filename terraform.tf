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
  url      = var.endpoint
  username = var.username
  password = var.password
}
