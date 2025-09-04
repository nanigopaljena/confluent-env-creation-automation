output "create_liam_default_topic" {
  description = "The topic created for LIAM"
  value       = "Topic Name is: ${confluent_kafka_topic.create_liam_default_topic.topic_name} and ID is: ${confluent_kafka_topic.create_liam_default_topic.id}"
}

output "create_liam_sa" {
  description = "The service account created for LIAM"
  value       = "ServiceAccount name is: ${confluent_service_account.create_liam_sa.display_name} and ID is: ${confluent_service_account.create_liam_sa.id}"
}

output "create_gravitee_sa" {
  description = "The service account created for Gravitee"
  value       = "ServiceAccount name is: ${confluent_service_account.create_gravitee_sa.display_name} and ID is: ${confluent_service_account.create_gravitee_sa.id}"
}

output "create_api_key_for_liam_sa" {
  sensitive   = true
  description = "The API key created for LIAM service account"
  value       = "API Key is: ${confluent_api_key.create_api_key_for_liam_sa.id} and secret is: ${confluent_api_key.create_api_key_for_liam_sa.secret}"
}

output "create_api_key_for_gravitee_sa" {
  sensitive   = true
  description = "The API key created for Gravitee service account"
  value       = "API Key is: ${confluent_api_key.create_api_key_for_gravitee_sa.id} and secret is: ${confluent_api_key.create_api_key_for_gravitee_sa.secret}"
}
