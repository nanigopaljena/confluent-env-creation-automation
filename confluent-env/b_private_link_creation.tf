# locals {
#   env_name     = "${var.by_env}-${var.region}"
#   network_name = "${local.env_name}-nm-02"
# }
#
# # Use the environment we created
# data "confluent_environment" "env" {
#   id = confluent_environment.this.id
# }
#
# # Create PrivateLink network
# resource "confluent_network" "privatelink_network" {
#   display_name = local.network_name
#   cloud        = "AZURE"
#   region       = var.region
#
#   environment {
#     id = data.confluent_environment.env.id
#   }
#
#   connection_types = ["PRIVATELINK"]
# }
#
# # Outputs for visibility
# output "network_id" {
#   description = "The ID of the created Confluent PrivateLink network."
#   value       = confluent_network.privatelink_network.id
# }
#
# output "network_name" {
#   description = "The name of the created Confluent PrivateLink network."
#   value       = confluent_network.privatelink_network.display_name
# }
