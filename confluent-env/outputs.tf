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

output "service_account_api_keys" {
  description = "API keys and secrets for each service account"
  value = {
    for sa, key in confluent_api_key.sa_keys :
    sa => {
      api_key    = key.id
      api_secret = key.secret
    }
  }
  sensitive = false
}