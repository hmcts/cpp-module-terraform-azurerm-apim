resource "azurerm_api_management_subscription" "apim" {
  for_each            = { for apim_subscriptions in var.apim_subscriptions : apim_subscriptions.user_id => apim_subscriptions }
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  user_id             = each.value.user_id
  product_id          = each.value.product_id
  display_name        = each.value.display_name

  depends_on = [azurerm_api_management_user.user,azurerm_api_management_product.product]
}

