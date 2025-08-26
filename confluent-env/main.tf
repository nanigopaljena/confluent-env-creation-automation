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

# Create Environment
resource "confluent_environment" "this" {
  display_name = "${var.by_env}-${var.region}-environment"
}

# Local map: fully qualified SA names → roles
locals {
  service_accounts = {
    for sa in var.service_accounts :
    "${sa.name}-${var.by_env}-${var.region}" => sa.roles
  }
}

# Service Accounts
resource "confluent_service_account" "accounts" {
  for_each = local.service_accounts

  display_name = each.key
  description  = "Service account for ${each.key}"
}

# Env-level binding
resource "confluent_role_binding" "env_roles" {
  for_each = confluent_service_account.accounts

  principal   = "User:${each.value.id}"
  crn_pattern = confluent_environment.this.resource_name
  role_name   = "MetricsViewer"
}

# Org-level binding (only for those with AccountAdmin)
resource "confluent_role_binding" "org_account_admin" {
  for_each = {
    for name, roles in local.service_accounts :
    name => roles
    if contains(roles, "AccountAdmin")
  }

  principal   = "User:${confluent_service_account.accounts[each.key].id}"
  crn_pattern = "crn://confluent.cloud/organization=${var.organization_id}"
  role_name   = "AccountAdmin"
}

