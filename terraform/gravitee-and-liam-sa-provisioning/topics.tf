resource "confluent_kafka_topic" "liam_default" {
  count = var.default_topic_for_liam ? 1 : 0

  environment {
    id = var.confluent_environment_id
  }

  kafka_cluster {
    id = var.kafka_cluster_id
  }

  topic_name       = "${var.by_env}.${var.region}.global.liam.gravitee-audit.event"
  partitions_count = 3
}
