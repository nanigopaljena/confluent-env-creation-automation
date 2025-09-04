resource "confluent_service_account" "create_liam_sa" {
  display_name = "ef-liam-${var.confluent_environment_name}-sa"
  description  = "Service account for LIAM in ${var.confluent_environment_name}"

  lifecycle {
    prevent_destroy = true
  }

}

resource "confluent_service_account" "create_gravitee_sa" {
  display_name = "ef-gravitee-${var.confluent_environment_name}-sa"
  description  = "Service account for Gravitee in ${var.confluent_environment_name}"

  lifecycle {
    prevent_destroy = true
  }
}


