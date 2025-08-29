resource "confluent_service_account" "gravitee" {
  count        = var.sa_for_gravitee ? 1 : 0
  display_name = "ef-gravitee-${var.confluent_environment_name}-sa"
  description  = "Service account for Gravitee in ${var.confluent_environment_name}"
}

resource "confluent_service_account" "liam" {
  count        = var.sa_for_liam ? 1 : 0
  display_name = "ef-liam-${var.confluent_environment_name}-sa"
  description  = "Service account for LIAM in ${var.confluent_environment_name}"
}