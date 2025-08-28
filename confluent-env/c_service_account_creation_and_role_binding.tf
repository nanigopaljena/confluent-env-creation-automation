# Create service accounts
resource "confluent_service_account" "accounts" {
  for_each = { for sa in var.service_accounts : sa.name => sa }

  display_name = each.value.name
  description  = "Service account for ${each.value.name}"
}

# Flatten account + roles into { "account.role" => {name, role} }
locals {
  account_roles = {
    for ar in flatten([
      for sa in var.service_accounts : [
        for role in sa.roles : {
          key  = "${sa.name}.${role}"
          name = sa.name
          role = role
        }
      ]
    ]) : ar.key => {
      name = ar.name
      role = ar.role
    }
  }
}


# Create role bindings
resource "confluent_role_binding" "bindings" {
  for_each = local.account_roles

  principal = "User:${confluent_service_account.accounts[each.value.name].id}"

  crn_pattern = (
    each.value.role == "AccountAdmin"
      ? "crn://confluent.cloud/organization=${var.organization_id}"
      : confluent_environment.this.resource_name
  )

  role_name = each.value.role
}
