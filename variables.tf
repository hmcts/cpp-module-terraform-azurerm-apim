variable "environment" {
  description = "Project environment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location."
  type        = string
}

variable "sku_name" {
  type        = string
  description = "String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity"
  default     = "Basic_1"
}

variable "publisher_name" {
  type        = string
  description = "The name of publisher/company."
}

variable "publisher_email" {
  type        = string
  description = "The email of publisher/company."
}

variable "additional_location" {
  type        = list(map(string))
  description = "List of the name of the Azure Region in which the API Management Service should be expanded to."
  default     = []
}

variable "zones" {
  type        = list(number)
  description = "(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier."
  default     = [1, 2, 3]
}

variable "certificate_configuration" {
  type        = list(map(string))
  description = "List of certificate configurations"
  default     = []
}

variable "client_certificate_enabled" {
  type        = bool
  description = "(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`."
  default     = false
}

variable "gateway_disabled" {
  type        = bool
  description = "(Optional) Disable the gateway in main region? This is only supported when `additional_location` is set."
  default     = false
}

variable "min_api_version" {
  type        = string
  description = "(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than."
  default     = null
}

variable "enable_http2" {
  type        = bool
  description = "Should HTTP/2 be supported by the API Management Service?"
  default     = false
}

variable "management_hostname_configuration" {
  type        = list(map(string))
  description = "List of management hostname configurations"
  default     = []
}

variable "scm_hostname_configuration" {
  type        = list(map(string))
  description = "List of scm hostname configurations"
  default     = []
}

variable "proxy_hostname_configuration" {
  type        = list(map(string))
  description = "List of proxy hostname configurations"
  default     = []
}

variable "portal_hostname_configuration" {
  type        = list(map(string))
  description = "Legacy portal hostname configurations"
  default     = []
}

variable "gateway_hostname_configuration" {
  type        = list(map(string))
  description = "gateway hostname configurations"
  default     = []
}

variable "developer_portal_hostname_configuration" {
  type        = list(map(string))
  description = "Developer portal hostname configurations"
  default     = []
}

variable "notification_sender_email" {
  type        = string
  description = "Email address from which the notification will be sent"
  default     = null
}

variable "policy_configuration" {
  type        = map(string)
  description = "Map of policy configuration"
  default     = {}
}

variable "enable_sign_in" {
  type        = bool
  description = "Should anonymous users be redirected to the sign in page?"
  default     = false
}

variable "enable_sign_up" {
  type        = bool
  description = "Can users sign up on the development portal?"
  default     = false
}

variable "terms_of_service_configuration" {
  type        = list(map(string))
  description = "Map of terms of service configuration"

  default = [{
    consent_required = false
    enabled          = false
    text             = ""
  }]
}

variable "security_configuration" {
  type        = map(string)
  description = "Map of security configuration"
  default     = {}
}

### NETWORKING

variable "virtual_network_type" {
  type        = string
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
  default     = null
}

variable "virtual_network_configuration" {
  type        = list(string)
  description = "The id(s) of the subnet(s) that will be used for the API Management. Required when virtual_network_type is External or Internal"
  default     = []
}

variable "nsg_name" {
  type        = string
  description = "NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private"
  default     = null
}

variable "nsg_rg_name" {
  type        = string
  description = "Name of the RG hosting the NSG if it's different from the one hosting the APIM"
  default     = null
}

variable "create_management_rule" {
  type        = bool
  description = "Whether to create the NSG rule for the management port of the APIM. If true, nsg_name variable must be set"
  default     = false
}

variable "management_nsg_rule_priority" {
  type        = number
  description = "Priority of the NSG rule created for the management port of the APIM"
  default     = 101
}

### IDENTITY

variable "identity_type" {
  description = "Type of Managed Service Identity that should be configured on this API Management Service"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned."
  type        = list(string)
  default     = []
}

variable "named_values" {
  description = "Map containing the name of the named values as key and value as values"
  type        = list(map(string))
  default     = []
}

variable "apim_subscriptions" {
  type = set(object({
    user_id      = string
    display_name = string
    product_id   = string
  }))
  default     = []
  description = "APIM Sbscriptions"
}

variable "apim_users" {
  type = set(object({
    user_id    = string
    first_name = string
    last_name  = string
    email      = string
  }))
  default     = []
  description = "APIM Users"
}

variable "apim_groups" {
  type = set(object({
    display_name = string
    name         = string
    description  = string
  }))
  default     = []
  description = "APIM Groups"
}

variable "apim_group_users" {
  type = set(object({
    user_id    = string
    group_name = string
  }))
  default     = []
  description = "APIM Users to assign to Groups"
}

variable "apim_product" {
  type = set(object({
    description           = string
    product_id            = string
    display_name          = string
    approval_required     = bool
    published             = bool
    subscription_required = bool
  }))
  default     = []
  description = "APIM Product"
}

variable "apim_product_group" {
  type = set(object({
    product_id = string
    group_name = string
  }))
  default     = []
  description = "APIM Groups to assign to Products"
}

variable "vault_path" {
  type        = string
  description = "vault path for certificate"
}

variable "vault_role" {
  type        = string
  description = "vault path for certificate"
}
