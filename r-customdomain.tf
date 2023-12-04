resource "azurerm_api_management_custom_domain" "custom" {
  count = length(concat(
    var.developer_portal_hostname_configuration,
    var.management_hostname_configuration,
    var.gateway_hostname_configuration
  )) == 0 ? 0 : 1
  api_management_id = azurerm_api_management.apim.id

  dynamic "developer_portal" {
    for_each = var.developer_portal_hostname_configuration
    content {
      host_name                    = developer_portal.value.host_name
      key_vault_id                 = developer_portal.value.keyvault_cert_id
      negotiate_client_certificate = lookup(developer_portal.value, "negotiate_client_certificate", false)
    }
  }
  dynamic "management" {
    for_each = var.management_hostname_configuration
    content {
      host_name                    = management.value.host_name
      key_vault_id                 = management.value.keyvault_cert_id
      negotiate_client_certificate = lookup(management.value, "negotiate_client_certificate", false)
    }
  }
  dynamic "gateway" {
    for_each = var.gateway_hostname_configuration
    content {
      host_name                    = gateway.value.host_name
      key_vault_id                 = gateway.value.keyvault_cert_id
      negotiate_client_certificate = lookup(gateway.value, "negotiate_client_certificate", false)
      default_ssl_binding          = true
    }
  }
}
