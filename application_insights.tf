resource "azurerm_application_insights" "insightsfrontend" {
  name                = "${local.ai_frontend_name}"
  location            = "${local.location}"
  resource_group_name = "${local.location}-${local.env}-${local.owner}-rg"
  application_type    = "other"
  tags                = local.common_tags
}

output "instrumentation_key_frontend" {
  value = "${azurerm_application_insights.insightsfrontend.instrumentation_key}"
  sensitive   = true
}

output "app_id_frontend" {
  value = "${azurerm_application_insights.insightsfrontend.app_id}"
  sensitive   = true
}
