# ---------------------------
# LIAM Role Bindings
# ---------------------------

# LIAM owns its topic
resource "confluent_role_binding" "liam_topic_owner" {
  count = var.sa_for_liam && var.default_topic_for_liam ? 1 : 0

  principal   = "User:${confluent_service_account.liam[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = confluent_kafka_topic.liam_default[0].crn
}

# LIAM owns its consumer group(s)
resource "confluent_role_binding" "liam_consumer_group_owner" {
  count = var.sa_for_liam ? 1 : 0

  principal   = "User:${confluent_service_account.liam[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${var.confluent_environment_id}/kafka=${var.confluent_kafka_cluster_id}/consumer-group=${var.liam_project_name}*"
}


# ---------------------------
# Gravitee Role Bindings
# ---------------------------

# Gravitee owns its consumer group(s)
resource "confluent_role_binding" "gravitee_consumer_group_owner" {
  count = var.sa_for_gravitee ? 1 : 0

  principal   = "User:${confluent_service_account.gravitee[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${var.confluent_environment_id}/kafka=${var.confluent_kafka_cluster_id}/consumer-group=*"
}
