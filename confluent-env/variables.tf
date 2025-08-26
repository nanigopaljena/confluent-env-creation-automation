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

variable "environment_name" {
  description = "Name of the Confluent environment"
  type        = string
}

variable "service_accounts" {
  description = "List of service accounts with roles"
  type = list(object({
    name  = string
    roles = list(string)
  }))
}
