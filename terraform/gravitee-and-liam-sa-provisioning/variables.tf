variable "confluent_cloud_api_key" {}
variable "confluent_cloud_api_secret" {}

variable "by_env" {
  description = "Target environment (dev, stage, prod)"
  type        = string
}

variable "confluent_environment_name" {
  description = "Environment name (e.g. sbx-us-eastus2)"
}


variable "region" {
  description = "Region (e.g. eastus2)"
}

variable "confluent_environment_id" {
  description = "Confluent Cloud environment ID (e.g. env-abcd12)"
}

variable "kafka_cluster_id" {
  description = "Kafka cluster ID"
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
}
