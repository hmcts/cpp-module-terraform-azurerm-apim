resource "azurerm_api_management_product" "product" {
  for_each              = { for apim_product in var.apim_product : apim_product.product_id => apim_product }
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = var.resource_group_name
  product_id            = each.value.product_id
  description           = each.value.description
  display_name          = each.value.display_name
  approval_required     = each.value.approval_required
  published             = each.value.published
  subscription_required = each.value.subscription_required
}

resource "azurerm_api_management_product_group" "product_group" {
  for_each            = { for apim_product_group in var.apim_product_group : apim_product_group.product_id => apim_product_group }
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  product_id          = each.value.product_id
  group_name          = each.value.group_name

  depends_on = [
    azurerm_api_management_group.group,
    azurerm_api_management_product.product
  ]
}
