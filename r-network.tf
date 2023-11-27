resource "azurerm_network_security_rule" "management_apim" {
  count                       = var.create_management_rule ? 1 : 0
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = local.nsg_rule_name
  network_security_group_name = var.nsg_name
  priority                    = var.management_nsg_rule_priority
  protocol                    = "Tcp"
  resource_group_name         = var.nsg_rg_name == null ? var.resource_group_name : var.nsg_rg_name

  source_port_range          = "*"
  destination_port_range     = "3443"
  source_address_prefix      = "ApiManagement"
  destination_address_prefix = "VirtualNetwork"
}

resource "azurerm_private_dns_a_record" "external_aks_ingress_mgmt_a" {
  for_each            = { for gw in concat(var.gateway_hostname_configuration, var.management_hostname_configuration, var.developer_portal_hostname_configuration) : gw.host_name => gw }
  name                = element(split(".", each.value.host_name), 0)
  zone_name           = var.dns_zone.name
  resource_group_name = var.dns_zone.rg_name
  ttl                 = 300
  records             = azurerm_api_management.apim.private_ip_addresses
}
