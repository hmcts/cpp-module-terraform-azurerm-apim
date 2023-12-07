variable "location" {
  description = "Azure location."
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku_name" {
  type        = string
  description = "String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity"
  default     = "Developer_1"
}

variable "publisher_name" {
  type        = string
  description = "The name of publisher/company."
  default     = "Ministry of Justice"
}

variable "publisher_email" {
  type        = string
  description = "The email of publisher/company."
  default     = "ems@hmcts.net"
}

variable "named_values" {
  description = "Map containing the name of the named values as key and value as values"
  type        = list(map(string))
  default     = []
}

variable "apim_name" {
  description = "APIM name"
  type        = string
}

variable "virtual_network_type" {
  type        = string
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
  default     = "Internal"
}

variable "subnet_details" {
  type = object({
    name             = string
    rg_name          = string
    vnet             = string
    address_prefixes = list(string)
  })
  description = "The id(s) of the subnet(s) that will be used for the API Management. Required when virtual_network_type is External or Internal"
}

variable "zones" {
  type        = list(number)
  description = "(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier."
  default     = []
}

variable "dns_zone" {
  type = object({
    name    = string
    rg_name = string
  })
  description = "dns zone details"
}

variable "diagnostics" {
  description = "List of diagnostics settings"
  type = list(object({
    name = string
    logs = list(object({
      category = string
      enabled  = bool
    }))
    metrics = list(object({
      category = string
      enabled  = bool
    }))
    event_hub_authorization_rule_id = string
    event_hub_name                  = string
    storage_account_id              = optional(string)
  }))
  default = []
}
