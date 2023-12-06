# Azure API Management feature
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/api-management/azurerm/)

This Terraform module creates an [Azure API Management](https://docs.microsoft.com/en-us/azure/api-management/).

## Requirements

* [AzureRM Terraform provider](https://www.terraform.io/docs/providers/azurerm/) >= 1.32

## Usage

```hcl

module "apim" {
  source  = "claranet/api-management/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  environment    = var.environment

  resource_group_name = module.rg.resource_group_name

  sku_name        = "Standard_1"
  publisher_name  = "Contoso ApiManager"
  publisher_email = "api_manager@test.com"

  named_values = [
    {
      name   = "my_named_value"
      value  = "my_secret_value"
      secret = true
    },
    {
      display_name = "My second value explained"
      name         = "my_second_value"
      value        = "my_not_secret_value"
    }
  ]

  additional_location = [
    {
      location  = "eastus2"
      subnet_id = var.subnet_id
    },
  ]

}
```

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 3.22 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | 6.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_group.group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.named_values](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product.product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) | resource |
| [azurerm_api_management_product_group.product_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_location | List of the name of the Azure Region in which the API Management Service should be expanded to. | `list(map(string))` | `[]` | no |
| certificate\_configuration | List of certificate configurations | `list(map(string))` | `[]` | no |
| client\_certificate\_enabled | (Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`. | `bool` | `false` | no |
| create\_management\_rule | Whether to create the NSG rule for the management port of the APIM. If true, nsg\_name variable must be set | `bool` | `false` | no |
| create\_product\_group\_and\_relationships | Create local APIM groups with name identical to products and create a relationship between groups and products | `bool` | `false` | no |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_management\_rule\_name | Custom NSG rule name for APIM Management. | `string` | `""` | no |
| custom\_name | Custom API Management name, generated if not set. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags | `bool` | `true` | no |
| developer\_portal\_hostname\_configuration | Developer portal hostname configurations | `list(map(string))` | `[]` | no |
| enable\_http2 | Should HTTP/2 be supported by the API Management Service? | `bool` | `false` | no |
| enable\_sign\_in | Should anonymous users be redirected to the sign in page? | `bool` | `false` | no |
| enable\_sign\_up | Can users sign up on the development portal? | `bool` | `false` | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Extra tags to add | `map(string)` | `{}` | no |
| gateway\_disabled | (Optional) Disable the gateway in main region? This is only supported when `additional_location` is set. | `bool` | `false` | no |
| identity\_ids | A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned. | `list(string)` | `[]` | no |
| identity\_type | Type of Managed Service Identity that should be configured on this API Management Service | `string` | `"SystemAssigned"` | no |
| location | Azure location for Eventhub. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| logs\_retention\_days | Number of days to keep logs on storage account. | `number` | `30` | no |
| management\_hostname\_configuration | List of management hostname configurations | `list(map(string))` | `[]` | no |
| management\_nsg\_rule\_priority | Priority of the NSG rule created for the management port of the APIM | `number` | `101` | no |
| min\_api\_version | (Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than. | `string` | `null` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| named\_values | Map containing the name of the named values as key and value as values | `list(map(string))` | `[]` | no |
| notification\_sender\_email | Email address from which the notification will be sent | `string` | `null` | no |
| nsg\_name | NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private | `string` | `null` | no |
| nsg\_rg\_name | Name of the RG hosting the NSG if it's different from the one hosting the APIM | `string` | `null` | no |
| policy\_configuration | Map of policy configuration | `map(string)` | `{}` | no |
| portal\_hostname\_configuration | Legacy portal hostname configurations | `list(map(string))` | `[]` | no |
| products | List of products to create | `list(string)` | `[]` | no |
| proxy\_hostname\_configuration | List of proxy hostname configurations | `list(map(string))` | `[]` | no |
| publisher\_email | The email of publisher/company. | `string` | n/a | yes |
| publisher\_name | The name of publisher/company. | `string` | n/a | yes |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| scm\_hostname\_configuration | List of scm hostname configurations | `list(map(string))` | `[]` | no |
| security\_configuration | Map of security configuration | `map(string)` | `{}` | no |
| sku\_name | String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity | `string` | `"Basic_1"` | no |
| terms\_of\_service\_configuration | Map of terms of service configuration | `list(map(string))` | <pre>[<br>  {<br>    "consent_required": false,<br>    "enabled": false,<br>    "text": ""<br>  }<br>]</pre> | no |
| virtual\_network\_configuration | The id(s) of the subnet(s) that will be used for the API Management. Required when virtual\_network\_type is External or Internal | `list(string)` | `[]` | no |
| virtual\_network\_type | The type of virtual network you want to use, valid values include: None, External, Internal. | `string` | `null` | no |
| zones | (Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier. | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| api\_management\_additional\_location | Map listing gateway\_regional\_url and public\_ip\_addresses associated |
| api\_management\_gateway\_regional\_url | The Region URL for the Gateway of the API Management Service |
| api\_management\_gateway\_url | The URL of the Gateway for the API Management Service |
| api\_management\_id | The ID of the API Management Service |
| api\_management\_identity | The identity of the API Management |
| api\_management\_management\_api\_url | The URL for the Management API associated with this API Management service |
| api\_management\_name | The name of the API Management Service |
| api\_management\_portal\_url | The URL for the Publisher Portal associated with this API Management service |
| api\_management\_private\_ip\_addresses | The Private IP addresses of the API Management Service |
| api\_management\_public\_ip\_addresses | The Public IP addresses of the API Management Service |
| api\_management\_scm\_url | The URL for the SCM Endpoint associated with this API Management service |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [https://docs.microsoft.com/en-us/azure/api-management/](https://docs.microsoft.com/en-us/azure/api-management/)
