locals {
  env_name     = "${var.by_env}-${var.geography}-${var.region}"
  network_name = "${var.by_env}-${var.geography}-${var.region}-nm-01"
}

data "confluent_environment" "env" {
  id = confluent_environment.environment.id
}

resource "confluent_network" "create_private_network" {
  display_name = local.network_name
  cloud        = "AZURE"
  region       = var.region

  environment {
    id = data.confluent_environment.env.id
  }

  connection_types = ["PRIVATELINK"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_private_link_access" "create_azure_pla" {
  display_name = "${local.env_name}-pla"

  environment {
    id = data.confluent_environment.env.id
  }

  network {
    id = confluent_network.create_private_network.id
  }

  azure {
    subscription = var.azure_subscription_id
  }

  lifecycle {
    prevent_destroy = true
  }
}