resource "azurerm_api_management_custom_domain" "gateway" {
  for_each          = toset(var.gateway_hostname_configuration)
  api_management_id = azurerm_api_management.apim.id

  gateway {
    host_name    = each.value.hostname
    key_vault_id = try(each.value.key_vault_id, null)
    certificate  = try(each.value.certificate, null)
  }
}
