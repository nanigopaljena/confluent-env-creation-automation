terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.10.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

# Create Confluent Environment
resource "confluent_environment" "this" {
  display_name = var.environment_name
}

# Create Service Accounts
resource "confluent_service_account" "accounts" {
  for_each     = { for sa in var.service_accounts : sa.name => sa }
  display_name = each.value.name
  description  = "Service account for ${each.value.name}"
}

# Assign Roles
resource "confluent_role_binding" "bindings" {
  for_each = {
    for sa in var.service_accounts : sa.name => {
      sa_id = confluent_service_account.accounts[sa.name].id
      roles = sa.roles
    }
  }

  dynamic "binding" {
    for_each = each.value.roles
    content {
      principal   = "User:${each.value.sa_id}"
      role_name   = binding.value
      crn_pattern = confluent_environment.this.resource_name
    }
  }
}
