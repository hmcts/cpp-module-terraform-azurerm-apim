resource "azurerm_api_management_subscription" "apim" {
  for_each            = { for subscriptions in var.apim_subscriptions : subscriptions.product_id => subscriptions }
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  user_id             = azurerm_api_management_user.user[each.value.user_id].id
  product_id          = azurerm_api_management_product.product[each.value.product_id].id
  display_name        = each.value.display_name

  depends_on = [azurerm_api_management_user.user, azurerm_api_management_product.product]
}
