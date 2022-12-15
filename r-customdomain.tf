resource "vault_pki_secret_backend_cert" "app" {
  for_each    = { for gw in concat(var.gateway_hostname_configuration, var.management_hostname_configuration, var.developer_portal_hostname_configuration) : gw.host_name => gw }
  backend     = var.vault_path
  name        = var.vault_role
  common_name = each.value.host_name
}

resource "pkcs12_from_pem" "my_pkcs12" {
  for_each        = { for gw in concat(var.gateway_hostname_configuration, var.management_hostname_configuration, var.developer_portal_hostname_configuration) : gw.host_name => gw }
  password        = var.cert_password
  cert_pem        = vault_pki_secret_backend_cert.app[each.value.host_name].certificate
  private_key_pem = vault_pki_secret_backend_cert.app[each.value.host_name].private_key
  ca_pem          = vault_pki_secret_backend_cert.app[each.value.host_name].issuing_ca
}

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
      certificate                  = pkcs12_from_pem.my_pkcs12[developer_portal.value.host_name].result
      certificate_password         = var.cert_password
      negotiate_client_certificate = lookup(developer_portal.value, "negotiate_client_certificate", false)
    }
  }
  dynamic "management" {
    for_each = var.management_hostname_configuration
    content {
      host_name                    = management.value.host_name
      certificate                  = pkcs12_from_pem.my_pkcs12[management.value.host_name].result
      certificate_password         = var.cert_password
      negotiate_client_certificate = lookup(management.value, "negotiate_client_certificate", false)
    }
  }
  dynamic "gateway" {
    for_each = var.gateway_hostname_configuration
    content {
      host_name                    = gateway.value.host_name
      certificate                  = pkcs12_from_pem.my_pkcs12[gateway.value.host_name].result
      certificate_password         = var.cert_password
      negotiate_client_certificate = lookup(gateway.value, "negotiate_client_certificate", false)
      default_ssl_binding          = true
    }
  }
}
