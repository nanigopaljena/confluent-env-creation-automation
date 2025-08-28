variable "by_env" {
  description = "Target environment (dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "Cloud region (e.g., eastus2, westus2)"
  type        = string
}

variable "service_accounts" {
  description = "List of service accounts and their roles"
  type = list(object({
    name  = string
    roles = list(string)
  }))
  default = [
    { name = "env-automation", roles = ["Operator", "DataDiscovery", "DataSteward", "AccountAdmin", "EnvironmentAdmin", "ResourceKeyAdmin", "MetricsViewer"] },
    { name = "metrics-reader", roles = ["MetricsViewer", "Operator"] }
  ]
}

variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key"
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "organization_id" {
  description = "Confluent Cloud Organization ID"
  type        = string
}

# Azure authentication (GitHub secrets)
# variable "azure_subscription_id" {
#   description = "Azure Subscription ID"
#   type        = string
#   sensitive   = true
# }
#
# variable "azure_tenant_id" {
#   description = "Azure Tenant ID"
#   type        = string
#   sensitive   = true
# }
#
# variable "azure_client_id" {
#   description = "Azure Service Principal App ID"
#   type        = string
#   sensitive   = true
# }
#
# variable "azure_client_secret" {
#   description = "Azure Service Principal Secret"
#   type        = string
#   sensitive   = true
# }
#
# # Key Vault info
# variable "key_vault_name" {
#   description = "Azure Key Vault name"
#   type        = string
# }
#
# variable "key_vault_rg" {
#   description = "Resource Group where the Key Vault resides"
#   type        = string
# }


