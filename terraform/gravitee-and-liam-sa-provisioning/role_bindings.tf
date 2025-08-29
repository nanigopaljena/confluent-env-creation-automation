# LIAM owns its topic
resource "confluent_role_binding" "liam_topic_owner" {
  count = var.sa_for_liam && var.default_topic_for_liam ? 1 : 0

  principal   = "User:${confluent_service_account.liam[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${var.confluent_environment_id}/kafka-cluster=${var.confluent_kafka_cluster_id}/topic=${confluent_kafka_topic.liam_default[0].topic_name}"
}

# LIAM owns its consumer group(s)
resource "confluent_role_binding" "liam_consumer_group_admin" {
  count = var.sa_for_liam ? 1 : 0

  principal   = "User:${confluent_service_account.liam[0].id}"
  role_name   = "ConsumerGroupAdmin"
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${var.confluent_environment_id}/kafka-cluster=${var.confluent_kafka_cluster_id}/consumer-group=${var.liam_project_name}*"
}

# Gravitee owns its consumer group(s)
resource "confluent_role_binding" "gravitee_consumer_group_admin" {
  count = var.sa_for_gravitee ? 1 : 0

  principal   = "User:${confluent_service_account.gravitee[0].id}"
  role_name   = "ConsumerGroupAdmin"
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${var.confluent_environment_id}/kafka-cluster=${var.confluent_kafka_cluster_id}/consumer-group=*"
}
