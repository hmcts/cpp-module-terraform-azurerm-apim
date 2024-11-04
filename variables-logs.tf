# Diag settings / logs parameters

variable "diagnostics" {
  description = "List of diagnostics settings"
  type = list(object({
    name = string
    logs = list(object({
      category = string
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
