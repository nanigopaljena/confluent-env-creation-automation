resource "confluent_role_binding" "assign_env_automation_roles" {
  for_each = toset(var.env_automation_roles)

  principal = "User:${confluent_service_account.create_env_automation_sa.id}"
  role_name = each.value

  crn_pattern = (
    contains(["AccountAdmin", "ResourceKeyAdmin"], each.value)
    ? "crn://confluent.cloud/organization=${var.confluent_organization_id}"
    : "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${confluent_environment.environment.id}"
  )

  depends_on = [
    confluent_service_account.create_env_automation_sa,
  ]

  lifecycle {
    prevent_destroy = true
  }
}


resource "confluent_role_binding" "assign_metrics_reader_roles" {
  for_each = toset(var.metrics_reader_roles)

  principal = "User:${confluent_service_account.create_metrics_reader_sa.id}"
  role_name = each.value

  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${confluent_environment.environment.id}"

  depends_on = [
    confluent_service_account.create_metrics_reader_sa,
  ]

  lifecycle {
    prevent_destroy = true
  }
}
