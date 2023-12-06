resource "azurerm_monitor_diagnostic_setting" "example" {
  count = length(var.diagnostics)

  name                           = var.diagnostics[count.index].name
  target_resource_id             = azurerm_api_management.apim.id
  eventhub_authorization_rule_id = var.diagnostics[count.index].event_hub_authorization_rule_id
  eventhub_name                  = var.diagnostics[count.index].event_hub_name
  storage_account_id             = lookup(var.diagnostics[count.index], "storage_account_id", null)

  dynamic "log" {
    for_each = var.diagnostics[count.index].logs
    content {
      category = log.value.category
      enabled  = log.value.enabled
    }
  }

  dynamic "metric" {
    for_each = var.diagnostics[count.index].metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled
    }
  }
}
