resource "confluent_kafka_topic" "liam_default" {
  count = var.default_topic_for_liam ? 1 : 0

  kafka_cluster {
    id = var.confluent_kafka_cluster_id
  }

  topic_name       = "${var.by_env}.${var.region}.global.liam.gravitee-audit.event"
  partitions_count = 3
  rest_endpoint    = "https://pkc-56d1g.eastus.azure.confluent.cloud:443"
  credentials {
    key    = var.confluent_cloud_api_key
    secret = var.confluent_cloud_api_secret
  }
}

