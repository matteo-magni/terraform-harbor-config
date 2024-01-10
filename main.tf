resource "harbor_project" "project" {
  for_each = var.projects

  name                        = each.key
  public                      = each.value.public
  registry_id                 = each.value.registry == null ? null : (contains(keys(harbor_registry.registry), each.value.registry) ? harbor_registry.registry[each.value.registry].registry_id : data.harbor_registry.registry[each.value.registry].registry_id)
  vulnerability_scanning      = each.value.vulnerability_scanning
  enable_content_trust        = each.value.enable_content_trust
  enable_content_trust_cosign = each.value.enable_content_trust_cosign
  storage_quota               = each.value.storage_quota
  cve_allowlist               = each.value.cve_allowlist
}

resource "harbor_registry" "registry" {
  for_each = var.registries

  name          = each.key
  provider_name = each.value.provider_name
  endpoint_url  = each.value.endpoint_url
  access_id     = contains(keys(var.registries_credentials), each.key) ? var.registries_credentials[each.key].access_id : null
  access_secret = contains(keys(var.registries_credentials), each.key) ? var.registries_credentials[each.key].access_secret : null
  insecure      = each.value.insecure
}

data "harbor_registry" "registry" {
  for_each = toset([for p in var.projects : p.registry if p.registry != null])

  name = each.key

  depends_on = [harbor_registry.registry]
}