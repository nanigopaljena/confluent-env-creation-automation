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

# Create Service Accounts with full names (name-env-region)
resource "confluent_service_account" "accounts" {
  for_each = {
    for sa in var.service_accounts :
    "${sa.name}-${var.by_env}-${var.region}" => {
      name  = "${sa.name}-${var.by_env}-${var.region}"
      roles = sa.roles
    }
  }

  display_name = each.value.name
  description  = "Service account for ${each.value.name}"
}

# Environment-level role bindings
resource "confluent_role_binding" "env_roles" {
  for_each = confluent_service_account.accounts

  principal   = "User:${each.value.id}"
  crn_pattern = confluent_environment.this.resource_name
  role_name   = "MetricsViewer"
}

# Organization-level AccountAdmin roles
resource "confluent_role_binding" "org_account_admin" {
  for_each = {
    for name, sa in confluent_service_account.accounts :
    name => sa
    if contains(sa.roles, "AccountAdmin")
  }

  principal   = "User:${each.value.id}"
  crn_pattern = "crn://confluent.cloud/organization=${var.organization_id}"
  role_name   = "AccountAdmin"
}
