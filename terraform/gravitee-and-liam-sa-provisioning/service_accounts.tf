# Gravitee Service Account
resource "confluent_service_account" "gravitee" {
  count        = var.sa_for_gravitee ? 1 : 0
  display_name = "ef-gravitee-${var.environment_name}-sa"
  description  = "Service account for Gravitee in ${var.environment_name}"
}

# Liam Service Account
resource "confluent_service_account" "liam" {
  count        = var.sa_for_liam ? 1 : 0
  display_name = "ef-liam-${var.environment_name}-sa"
  description  = "Service account for LIAM in ${var.environment_name}"
}
