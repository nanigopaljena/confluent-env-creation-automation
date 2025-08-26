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

  connection_types = ["privatelink"]
}

# Wait until network status = READY
resource "null_resource" "wait_for_network_ready" {
  depends_on = [confluent_network.privatelink_network]

  provisioner "local-exec" {
    command = <<EOT
      status=""
      while [ "$status" != "READY" ]; do
        status=$(confluent network list --environment ${data.confluent_environment.env.id} -o json | jq -r '.[] | select(.display_name=="${local.network_name}") | .phase')
        echo "Network status: $status"
        if [ "$status" != "READY" ]; then sleep 30; fi
      done
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
