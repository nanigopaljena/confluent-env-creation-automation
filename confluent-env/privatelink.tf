locals {
  env_name     = "${var.by_env}-${var.region}"
  network_name = "${local.env_name}-nm-02"
}

data "confluent_environment" "env" {
  id = confluent_environment.this.id
}

resource "confluent_network" "privatelink_network" {
  display_name = local.network_name
  cloud        = "AZURE"
  region       = var.region

  environment {
    id = data.confluent_environment.env.id
  }

  connection_types = ["PRIVATELINK"]
}

# Wait for up to 30 minutes, checking every 30 seconds
resource "time_sleep" "wait_30s" {
  count           = 60 # 60 x 30s = 30 minutes
  create_duration = "30s"
}

data "confluent_network" "privatelink_status" {
  id = confluent_network.privatelink_network.id

  environment {
    id = data.confluent_environment.env.id
  }

  depends_on = [time_sleep.wait_30s]
}

# Fail if not READY after 30 minutes
resource "null_resource" "fail_if_not_ready" {
  count = data.confluent_network.privatelink_status.phase == "READY" ? 0 : 1

  provisioner "local-exec" {
    command = "echo '❌ Timeout: Network not READY within 30 minutes.' && exit 1"
  }
}
