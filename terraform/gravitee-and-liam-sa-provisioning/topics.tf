resource "confluent_kafka_topic" "create_liam_default_topic" {
  kafka_cluster {
    id = var.confluent_kafka_cluster_id
  }

  topic_name       = "${var.by_env}.${var.region}.global.liam.gravitee-audit.event"
  partitions_count = 3
  rest_endpoint    = var.confluent_cluster_rest_endpoint

  credentials {
    key    = var.confluent_cluster_api_key
    secret = var.confluent_cluster_api_secret
  }

  lifecycle {
    prevent_destroy = true
  }
}