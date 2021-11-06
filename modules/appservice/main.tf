data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_app_service_plan" "this" {
  name                = var.azurerm_app_service_plan_name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  kind     = "Linux"
  reserved = true # `reserved` has to be set to true when kind is set to `Linux`

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = var.tags
}

resource "azurerm_app_service" "this" {
  name                = var.azurerm_app_service_name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id
  site_config {
    # when using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true
    use_32_bit_worker_process = true
    linux_fx_version          = "dotnetcore|5.0"
  }

  # app_settings = {
  #   "SOME_KEY" = "some-value"
  # }

  # connection_string {
  #   name  = "Database"
  #   type  = "SQLServer"
  #   value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  # }

  tags       = var.tags
  depends_on = [azurerm_app_service_plan.this]
}
