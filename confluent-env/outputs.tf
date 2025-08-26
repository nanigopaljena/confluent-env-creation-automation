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

