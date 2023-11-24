data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "apim" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_api_management.apim.identity.0.principal_id
}

data "azurerm_key_vault_certificate" "apim" {
  for_each     = toset(var.external_certs)
  name         = each.value
  key_vault_id = var.key_vault_id
  depends_on   = [azurerm_role_assignment.apim]
}

resource "azurerm_api_management_certificate" "external" {
  for_each            = toset(var.external_certs)
  name                = each.value
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  key_vault_secret_id = data.azurerm_key_vault_certificate.apim[each.value].secret_id
}
