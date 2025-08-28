# Lookup existing Key Vault
# data "azurerm_key_vault" "kv" {
#   name                = var.key_vault_name
#   resource_group_name = var.key_vault_rg
# }

# API Keys for each Service Account
resource "confluent_api_key" "sa_keys" {
  for_each = confluent_service_account.accounts

  display_name = "${each.key}-api-key"
  description  = "API Key for ${each.key}"
  owner {
    id          = each.value.id
    api_version = each.value.api_version
    kind        = each.value.kind
  }

  depends_on = [confluent_role_binding.env_roles]
}

# # Store API Key in Azure Key Vault
# resource "azurerm_key_vault_secret" "sa_api_key" {
#   for_each     = confluent_api_key.sa_keys
#   name         = "${each.key}-key"
#   value        = each.value.id
#   key_vault_id = data.azurerm_key_vault.kv.id
# }
#
# # Store API Secret in Azure Key Vault
# resource "azurerm_key_vault_secret" "sa_api_secret" {
#   for_each     = confluent_api_key.sa_keys
#   name         = "${each.key}-secret"
#   value        = each.value.secret
#   key_vault_id = data.azurerm_key_vault.kv.id
# }