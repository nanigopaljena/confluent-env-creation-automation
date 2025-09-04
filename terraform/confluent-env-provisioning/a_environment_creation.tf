terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.10.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}


# Create Environment
resource "confluent_environment" "environment" {
  display_name = "${var.by_env}-${var.geography}-${var.region}"

  lifecycle {
    prevent_destroy = true
  }
}
