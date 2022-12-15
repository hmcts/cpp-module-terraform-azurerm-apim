resource "vault_pki_secret_backend_cert" "app" {
  for_each    = { for gw in concat(var.gateway_hostname_configuration, var.management_hostname_configuration, var.developer_portal_hostname_configuration) : gw.host_name => gw }
  backend     = var.vault_path
  name        = var.vault_role
  common_name = each.value.host_name
}

resource "azurerm_api_management_custom_domain" "gateway" {
  for_each          = { for gw in var.gateway_hostname_configuration : gw.host_name => gw }
  api_management_id = azurerm_api_management.apim.id

  gateway {
    host_name                    = each.value.host_name
    certificate                  = vault_pki_secret_backend_cert.app[each.value.host_name].certificate
    negotiate_client_certificate = lookup(each.value, "negotiate_client_certificate", false)
    default_ssl_binding          = true
  }
}

resource "azurerm_api_management_custom_domain" "mgmt" {
  for_each          = { for mgmt in var.management_hostname_configuration : mgmt.host_name => mgmt }
  api_management_id = azurerm_api_management.apim.id

  management {
    host_name                    = each.value.host_name
    certificate                  = vault_pki_secret_backend_cert.app[each.value.host_name].certificate
    negotiate_client_certificate = lookup(each.value, "negotiate_client_certificate", false)
  }
}

resource "azurerm_api_management_custom_domain" "dev_portal" {
  for_each          = { for dev in var.developer_portal_hostname_configuration : dev.host_name => dev }
  api_management_id = azurerm_api_management.apim.id

  developer_portal {
    host_name                    = each.value.host_name
    certificate                  = vault_pki_secret_backend_cert.app[each.value.host_name].certificate
    negotiate_client_certificate = lookup(each.value, "negotiate_client_certificate", false)
  }
}
