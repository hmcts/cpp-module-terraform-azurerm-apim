resource "vault_pki_secret_backend_cert" "app" {
  for_each    = { for gw in var.gateway_hostname_configuration : gw.host_name => gw }
  backend     = var.vault_path
  name        = var.vault_role
  common_name = each.value.host_name
}

resource "azurerm_api_management_custom_domain" "gateway" {
  for_each          = { for gw in var.gateway_hostname_configuration : gw.host_name => gw }
  api_management_id = azurerm_api_management.apim.id

  gateway {
    host_name                    = each.value.host_name
    key_vault_id                 = try(each.value.key_vault_id, null)
    certificate                  = try(each.value.certificate, null)
    certificate_password         = lookup(each.value, "certificate_password", null)
    negotiate_client_certificate = lookup(each.value, "negotiate_client_certificate", false)
    default_ssl_binding          = true
  }
}
