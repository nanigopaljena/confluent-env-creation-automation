locals {
  # Split on "." and keep only the first 4 parts (up to liam)
  liam_topic_prefix = join(".", slice(split(".", confluent_kafka_topic.liam_default_topic[0].topic_name), 0, 4))
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${var.confluent_environment_id}/kafka-cluster=${var.confluent_kafka_cluster_id}"
}

# LIAM owns its topic
resource "confluent_role_binding" "liam_topic_owner" {
  count = var.sa_for_liam && var.default_topic_for_liam ? 1 : 0

  principal   = "User:${confluent_service_account.liam[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${local.crn_pattern}/topic=${local.liam_topic_prefix}"
}

# LIAM owns its consumer group(s)
resource "confluent_role_binding" "liam_consumer_group_owner" {
  count = var.sa_for_liam ? 1 : 0

  principal   = "User:${confluent_service_account.liam[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${local.crn_pattern}/consumer-group=${var.liam_project_name}"
}

# Gravitee owns its consumer group(s)
resource "confluent_role_binding" "gravitee_consumer_group_owner" {
  count = var.sa_for_gravitee ? 1 : 0

  principal   = "User:${confluent_service_account.gravitee[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${local.crn_pattern}/consumer-group=test"
}
