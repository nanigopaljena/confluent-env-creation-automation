resource "confluent_api_key" "create_api_key_for_liam_sa" {

  display_name = "${confluent_service_account.create_liam_sa.display_name}-sa-api-key"
  description  = "API Key for ${confluent_service_account.create_liam_sa.display_name}-sa"

  owner {
    id          = confluent_service_account.create_liam_sa.id
    api_version =confluent_service_account.create_liam_sa.api_version
    kind        = confluent_service_account.create_liam_sa.kind
  }

  depends_on = [confluent_service_account.create_liam_sa]

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_api_key" "create_api_key_for_gravitee_sa" {

  display_name = "${confluent_service_account.create_gravitee_sa.display_name}-sa-api-key"
  description  = "API Key for ${confluent_service_account.create_gravitee_sa.display_name}-sa"

  owner {
    id          = confluent_service_account.create_gravitee_sa.id
    api_version =confluent_service_account.create_gravitee_sa.api_version
    kind        = confluent_service_account.create_gravitee_sa.kind
  }

  depends_on = [confluent_service_account.create_gravitee_sa]

  lifecycle {
    prevent_destroy = true
  }
}