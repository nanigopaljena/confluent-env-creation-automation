output "environment_id" {
  description = "The ID of the created Confluent environment"
  value       = confluent_environment.this.id
}

output "service_accounts" {
  description = "Details of created service accounts"
  value = {
    for name, sa in confluent_service_account.accounts :
    "${sa.display_name}" => {
      id          = sa.id
      description = sa.description
    }
  }
}

output "service_account_api_keys" {
  description = "API keys and secrets for each service account"
  value = {
    for name, key in confluent_api_key.sa_keys :
    "${confluent_service_account.accounts[name].display_name}" => {
      api_key    = key.id
      api_secret = key.secret
    }
  }
  sensitive = true
}

output "network_id" {
  description = "The ID of the created Confluent PrivateLink network."
  value       = confluent_network.privatelink_network.id
}

output "network_name" {
  description = "The name of the created Confluent PrivateLink network."
  value       = confluent_network.privatelink_network.display_name
}

output "private_link_access_id" {
  description = "The ID of the Private Link Access created."
  value       = confluent_private_link_access.azure_pla.id
}

output "dns_info" {
  description = "DNS and alias details needed for SDS ticket."
  value = {
    dns_domain       = confluent_network.privatelink_network.dns_domain
    zonal_subdomains = confluent_network.privatelink_network.zonal_subdomains
    service_aliases  = confluent_network.privatelink_network.azure[0].private_link_service_aliases
  }
}