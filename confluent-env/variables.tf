variable "by_env" {
  description = "Base environment name (e.g., prod-cval-na)"
  type        = string
}

variable "region" {
  description = "Cloud region (e.g., eus2)"
  type        = string
}

variable "service_accounts" {
  description = "List of service accounts and their roles"
  type = list(object({
    name  = string
    roles = list(string)
  }))
  default = [
    { name = "env-automation", roles = ["EnvironmentAdmin", "AccountAdmin", "MetricsViewer", "DataSteward", "Operator"] },
    { name = "metrics-reader", roles = ["MetricsViewer", "DataSteward", "Operator"] }
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
