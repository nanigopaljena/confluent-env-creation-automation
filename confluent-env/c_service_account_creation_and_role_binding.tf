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

# Env-level binding (default = MetricsViewer)
resource "confluent_role_binding" "env_roles" {
  for_each = confluent_service_account.accounts

  principal   = "User:${each.value.id}"
  crn_pattern = confluent_environment.this.resource_name
  role_name   = "MetricsViewer"
}

# Org-level binding (only for AccountAdmin roles)
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
