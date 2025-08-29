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

variable "confluent_cluster_api_key" {
  description = "Cluster API Key"
  type        = string
  sensitive   = true
}

variable "confluent_cluster_api_secret" {
  description = "Cluster API Secret"
  type        = string
  sensitive   = true
}

variable "confluent_organization_id" {
  description = "Confluent Cloud Organization ID"
  type        = string
}

variable "confluent_environment_id" {
  description = "Confluent Cloud environment ID (e.g. env-abcd12)"
  type        = string
}

variable "confluent_environment_name" {
  description = "Environment name (e.g. sbx-us-eastus2)"
  type        = string
}

variable "confluent_kafka_cluster_id" {
  description = "Kafka cluster ID"
  type        = string
}

variable "by_env" {
  description = "Target environment (dev, sbx, tst, prod)"
  type        = string
}

variable "region" {
  description = "Region (e.g. eastus2)"
  type        = string
}

variable "sa_for_gravitee" {
  type    = bool
  default = false
}

variable "sa_for_liam" {
  type    = bool
  default = false
}

variable "default_topic_for_liam" {
  type    = bool
  default = false
}

variable "liam_project_name" {
  description = "Project name for LIAM (used in consumer group prefix, e.g. liam-dev)"
  type        = string
}
