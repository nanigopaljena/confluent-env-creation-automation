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

# Create Service Accounts
resource "confluent_service_account" "accounts" {
  for_each = { for sa in var.service_accounts : sa.name => sa }

  display_name = "${each.value.name}-${var.by_env}-${var.region}"
  description  = "Service account for ${each.value.name} in ${var.by_env}-${var.region}"
}

# Assign environment-level roles
resource "confluent_role_binding" "env_roles" {
  for_each = {
    for sa in var.service_accounts : sa.name => sa
    if length(sa.roles) > 0
  }

  principal   = "User:${confluent_service_account.accounts[each.key].id}"
  crn_pattern = confluent_environment.this.resource_name
  role_name   = "MetricsViewer" # You can expand to all roles dynamically
}

# Org-level roles (AccountAdmin only)
resource "confluent_role_binding" "org_account_admin" {
  for_each = {
    for sa in var.service_accounts : sa.name => sa
    if contains(sa.roles, "AccountAdmin")
  }

  principal   = "User:${confluent_service_account.accounts[each.key].id}"
  crn_pattern = "crn://confluent.cloud/organization=${var.organization_id}"
  role_name   = "AccountAdmin"
}

