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
# Role Bindings (one per role per SA)
# -----------------------------
locals {
  role_bindings = flatten([
    for sa in var.service_accounts : [
      for role in sa.roles : {
        sa_name = sa.name
        role    = role
      }
    ]
  ])
}

resource "confluent_role_binding" "bindings" {
  for_each = {
    for rb in local.role_bindings :
    "${rb.sa_name}-${rb.role}" => rb
  }

  principal   = "User:${confluent_service_account.accounts[each.value.sa_name].id}"
  role_name   = each.value.role
  crn_pattern = confluent_environment.this.resource_name
}
