locals {
  liam_topic_prefix = join(".", slice(split(".", confluent_kafka_topic.create_liam_default_topic[0].topic_name), 0, 4))
  crn_pattern = "crn://confluent.cloud/organization=${var.confluent_organization_id}/environment=${var.confluent_environment_id}/kafka-cluster=${var.confluent_kafka_cluster_id}"
}

resource "confluent_role_binding" "assign_liam_topic_owner_role" {
  principal   = "User:${confluent_service_account.create_liam_sa[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${local.crn_pattern}/kafka=${var.confluent_kafka_cluster_id}/topic=${local.liam_topic_prefix}*"

  depends_on = [
    confluent_service_account.create_liam_sa,
    confluent_kafka_topic.create_liam_default_topic
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_role_binding" "assign_liam_consumer_group_owner" {

  principal   = "User:${confluent_service_account.create_liam_sa[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${local.crn_pattern}/kafka=${var.confluent_kafka_cluster_id}/consumer-group=${var.liam_project_name}*"

  depends_on = [
    confluent_service_account.create_liam_sa
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_role_binding" "assign_gravitee_topic_owner" {

  principal   = "User:${confluent_service_account.create_gravitee_sa[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${local.crn_pattern}/kafka=${var.confluent_kafka_cluster_id}/topic=*"

  depends_on = [
    confluent_service_account.create_gravitee_sa
  ]

  lifecycle {
    prevent_destroy = true
  }

}

resource "confluent_role_binding" "assign_gravitee_consumer_group_owner" {

  principal   = "User:${confluent_service_account.create_gravitee_sa[0].id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${local.crn_pattern}/kafka=${var.confluent_kafka_cluster_id}/consumer-group=*"

  depends_on = [
    confluent_service_account.create_gravitee_sa
  ]

  lifecycle {
    prevent_destroy = true
  }

}



