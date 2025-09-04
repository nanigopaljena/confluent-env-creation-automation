variable "by_env" {
  description = "Target environment (dev, stage, prod)"
  type        = string
}

variable "geography" {
  description = "Cloud geography (e.g., us, eu, ap, au)"
  type        = string
}

variable "region" {
  description = "Cloud region code (e.g., eus2, cus, euw, sea, aue)"
  type        = string
}

variable "env_automation_roles" {
  description = "List of roles for env-automation service account"
  type        = list(string)
  default = ["Operator", "DataDiscovery", "DataSteward", "AccountAdmin", "EnvironmentAdmin", "ResourceKeyAdmin", "MetricsViewer"]
}

variable "metrics_reader_roles" {
  description = "List of roles for metrics-reader service account"
  type        = list(string)
  default = ["MetricsViewer", "Operator"]
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

variable "confluent_organization_id" {
  description = "Confluent Cloud Organization ID"
  type        = string
}

# Azure authentication (GitHub secrets)
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}
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


