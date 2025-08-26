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

# -----------------------------
# Confluent Environment
# -----------------------------
resource "confluent_environment" "this" {
  display_name = var.environment_name
}

# -----------------------------
# Service Accounts
# -----------------------------
resource "confluent_service_account" "accounts" {
  for_each     = { for sa in var.service_accounts : sa.name => sa }
  display_name = each.value.name
  description  = "Service account for ${each.value.name}"
}

# -----------------------------
# Role Bindings (one per role)
# -----------------------------
resource "confluent_role_binding" "bindings" {
  for_each = {
    for sa in var.service_accounts : sa.name => {
      sa_id = confluent_service_account.accounts[sa.name].id
      roles = sa.roles
    }
  }

  # Flatten roles into a single string to make unique keys
  principal   = "User:${each.value.sa_id}"
  role_name   = element(each.value.roles, 0)
  crn_pattern = confluent_environment.this.resource_name
}

# Alternative: if you want ALL roles created, not just the first one:
resource "confluent_role_binding" "all_roles" {
  for_each = {
    for sa in var.service_accounts : sa.name => {
      sa_id  = confluent_service_account.accounts[sa.name].id
      roles  = sa.roles
    }
  }

  principal   = "User:${each.value.sa_id}"
  role_name   = each.value.roles[count.index]
  crn_pattern = confluent_environment.this.resource_name
  count       = length(each.value.roles)
}
