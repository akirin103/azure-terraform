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
  https_only          = true
  enabled             = true

  logs {
    http_logs {
      file_system {
        retention_in_days = 30
        retention_in_mb   = 100
      }
    }
  }
  site_config {
    # when using an App Service Plan in the Free or Shared Tiers use_32_bit_worker_process must be set to true
    use_32_bit_worker_process = true
    linux_fx_version          = "dotnetcore|5.0"
  }

  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "1"
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

# resource "azurerm_app_service_virtual_network_swift_connection" "this" {
#   app_service_id = azurerm_app_service.this.id
#   subnet_id      = var.vnet_swift_connection
# }

resource "azurerm_private_dns_zone" "this" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = data.azurerm_resource_group.this.name
  depends_on = [azurerm_app_service.this]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszonelink" {
  name                  = "dnszonelink"
  resource_group_name   = data.azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = var.virtual_network_id
  depends_on = [azurerm_app_service.this]
}

resource "azurerm_private_endpoint" "this" {
  name                = "backwebappprivateendpoint"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = var.private_endpoint_subnet_id
  depends_on = [azurerm_app_service.this]

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.this.id]
  }

  private_service_connection {
    name                           = "privateendpointconnection"
    private_connection_resource_id = azurerm_app_service.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}
