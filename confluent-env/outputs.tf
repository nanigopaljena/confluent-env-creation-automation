output "environment_id" {
  value = confluent_environment.this.id
}

output "service_accounts" {
  value = {
    for name, sa in confluent_service_account.accounts : name => {
      id          = sa.id
      description = sa.description
    }
  }
}
