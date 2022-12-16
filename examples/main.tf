module "apim" {
  source = "../"

  location    = var.location
  environment = var.environment

  resource_group_name = var.resource_group_name

  sku_name        = var.sku_name
  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email

  named_values          = var.named_values
  logs_destinations_ids = var.logs_destinations_ids
  custom_name           = var.apim_name
  zones                 = var.zones
}
