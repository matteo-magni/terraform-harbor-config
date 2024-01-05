variable "endpoint" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "projects" {
  default = {}
  type = map(object({
    public                      = optional(bool, true)
    registry                    = optional(string, null)
    vulnerability_scanning      = optional(bool, true)
    enable_content_trust        = optional(bool, true)
    enable_content_trust_cosign = optional(bool, false)
    storage_quota               = optional(number, null)
    cve_allowlist               = optional(list(string), null)
  }))
}

resource "harbor_project" "main" {
  name                        = "main"
  public                      = false # (Optional) Default value is false
  vulnerability_scanning      = true  # (Optional) Default value is true. Automatically scan images on push
  enable_content_trust        = true  # (Optional) Default value is false. Deny unsigned images from being pulled (notary)
  enable_content_trust_cosign = false # (Optional) Default value is false. Deny unsigned images from being pulled (cosign)
}

variable "registries" {
  default = {}
  type = map(object({
    provider_name = string
    endpoint_url  = string
    description   = optional(string, null)
    insecure      = optional(bool, false)
  }))

  # validation {
  #   condition     = contains(["alibaba", "artifact-hub", "aws", "azure", "docker-hub", "docker-registry", "gitlab", "github", "google", "harbor", "helm", "huawei", "jfrog", "quay"], var.registries["provider_name"])
  #   error_message = "Allowed values for provider_name are \"alibaba\", \"artifact-hub\", \"aws\", \"azure\", \"docker-hub\", \"docker-registry\", \"gitlab\", \"github\", \"google\", \"harbor\", \"helm\", \"huawei\", \"jfrog\", \"quay\"."
  # }
}

variable "registries_credentials" {
  default = {}
  type = map(object({
    access_id     = string
    access_secret = string
  }))
  sensitive = true
}