locals {
  sa-name-suffix = "${var.by_env}-${var.geography}-${var.region}-sa"
}

resource "confluent_service_account" "create_env_automation_sa" {
  display_name = "env-automation-${local.sa-name-suffix}"
  description  = "Service account for env-automation-${local.sa-name-suffix} in ${confluent_environment.environment.display_name}"

  lifecycle {
    prevent_destroy = true
  }

}

resource "confluent_service_account" "create_metrics_reader_sa" {
  display_name = "metrics-reader-${local.sa-name-suffix}"
  description  = "Service account for env-automation-${local.sa-name-suffix} in ${confluent_environment.environment.display_name}"

  lifecycle {
    prevent_destroy = true
  }

}


