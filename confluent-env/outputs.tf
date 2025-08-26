output "environment_id" {
  description = "The ID of the created Confluent environment"
  value       = confluent_environment.this.id
}

output "service_accounts" {
  description = "Details of created service accounts"
  value = {
    for name, sa in confluent_service_account.accounts :
    name => {
      id          = sa.id
      description = sa.description
    }
  }
}

output "network_id" {
  description = "The ID of the created Confluent private link network."
  value       = confluent_network.privatelink_network.id
}

output "network_name" {
  description = "The name of the created Confluent private link network."
  value       = confluent_network.privatelink_network.display_name
}
