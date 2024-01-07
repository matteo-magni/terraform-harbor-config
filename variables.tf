variable "auth" {
  type = object({
    url         = string
    username    = string
    password    = string
    insecure    = optional(bool)
    api_version = optional(number)
  })
  sensitive = true
}

variable "projects" {
  default = {}
  type = map(object({
    public                      = optional(bool, true)
    registry                    = optional(string, null)
    vulnerability_scanning      = optional(bool, true)
    enable_content_trust        = optional(bool, false)
    enable_content_trust_cosign = optional(bool, false)
    storage_quota               = optional(number, null)
    cve_allowlist               = optional(list(string), null)
  }))
}

variable "registries" {
  default = {}
  type = map(object({
    provider_name = string
    endpoint_url  = string
    description   = optional(string, null)
    insecure      = optional(bool, false)
  }))

  validation {
    condition     = alltrue([for r in var.registries : contains(["alibaba", "artifact-hub", "aws", "azure", "docker-hub", "docker-registry", "gitlab", "github", "google", "harbor", "helm", "huawei", "jfrog", "quay"], r.provider_name)])
    error_message = "Allowed values for provider_name are \"alibaba\", \"artifact-hub\", \"aws\", \"azure\", \"docker-hub\", \"docker-registry\", \"gitlab\", \"github\", \"google\", \"harbor\", \"helm\", \"huawei\", \"jfrog\", \"quay\"."
  }
}

variable "registries_credentials" {
  default = {}
  type = map(object({
    access_id     = string
    access_secret = string
  }))
  sensitive = true
}