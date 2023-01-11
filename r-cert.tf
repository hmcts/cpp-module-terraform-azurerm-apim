data "azurerm_key_vault_certificate" "example" {
  for_each     = toset(var.external_certs)
  name         = each.value
  key_vault_id = var.key_vault_id
}

resource "azurerm_api_management_certificate" "external" {
  for_each            = toset(var.external_certs)
  name                = each.value
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  key_vault_secret_id = data.azurerm_key_vault_certificate.example[each.value].secret_id
}
