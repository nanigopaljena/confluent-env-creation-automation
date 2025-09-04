output "created_environment_id" {
  description = "The ID of the created Confluent environment"
  value       = confluent_environment.environment.id
}

output "created_environment_name" {
  description = "The name of the created Confluent environment"
  value       = confluent_environment.environment.display_name
}

output "created_network_id" {
  description = "The ID of the created Confluent PrivateLink network."
  value       = confluent_network.create_private_network.id
}

output "created_network_name" {
  description = "The name of the created Confluent PrivateLink network."
  value       = confluent_network.create_private_network.display_name
}

output "created_private_link_access_id" {
  description = "The ID of the Private Link Access created."
  value       = confluent_private_link_access.create_azure_pla.id
}

output "created_env_automation_sa" {
  description = "The service account created for env-automation"
  value       = "ServiceAccount name is: ${confluent_service_account.create_env_automation_sa.display_name} and ID is: ${confluent_service_account.create_env_automation_sa.id}"
}

output "created_metrics_reader_sa" {
  description = "The service account created for metrics-reader"
  value       = "ServiceAccount name is: ${confluent_service_account.create_metrics_reader_sa.display_name} and ID is: ${confluent_service_account.create_metrics_reader_sa.id}"
}

output "created_api_key_for_env_automation_sa" {
  sensitive   = true
  description = "The API key created for env-automation service account"
  value       = "API Key is: ${confluent_api_key.create_api_key_for_env_automation_sa.id} and secret is: ${confluent_api_key.create_api_key_for_env_automation_sa.secret}"
}

output "created_api_key_for_metrics_reader_sa" {
  sensitive   = true
  description = "The API key created for metrics-reader service account"
  value       = "API Key is: ${confluent_api_key.create_api_key_for_metrics_reader_sa.id} and secret is: ${confluent_api_key.create_api_key_for_metrics_reader_sa.secret}"
}

output "created_dns_info" {
  description = "DNS and alias details needed for SDS ticket."
  value = {
    dns_domain       = confluent_network.create_private_network.dns_domain
    zonal_subdomains = confluent_network.create_private_network.zonal_subdomains
    service_aliases  = confluent_network.create_private_network.azure[0].private_link_service_aliases
  }
}