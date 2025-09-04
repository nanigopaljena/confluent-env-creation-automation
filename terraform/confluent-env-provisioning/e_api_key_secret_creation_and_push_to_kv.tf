resource "confluent_api_key" "create_api_key_for_env_automation_sa" {

  display_name = "${confluent_service_account.create_env_automation_sa.display_name}-sa-api-key"
  description  = "API Key for ${confluent_service_account.create_env_automation_sa.display_name}-sa"

  owner {
    id          = confluent_service_account.create_env_automation_sa.id
    api_version =confluent_service_account.create_env_automation_sa.api_version
    kind        = confluent_service_account.create_env_automation_sa.kind
  }

  depends_on = [confluent_service_account.create_env_automation_sa]

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_api_key" "create_api_key_for_metrics_reader_sa" {

  display_name = "${confluent_service_account.create_metrics_reader_sa.display_name}-sa-api-key"
  description  = "API Key for ${confluent_service_account.create_metrics_reader_sa.display_name}-sa"

  owner {
    id          = confluent_service_account.create_metrics_reader_sa.id
    api_version =confluent_service_account.create_metrics_reader_sa.api_version
    kind        = confluent_service_account.create_metrics_reader_sa.kind
  }

  depends_on = [confluent_service_account.create_metrics_reader_sa]

  lifecycle {
    prevent_destroy = true
  }
}
