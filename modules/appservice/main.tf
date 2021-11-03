data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "random_integer" "sample" {
  min = 1
  max = 99999
}

resource "azurerm_app_service_plan" "this" {
  name                = "${var.azurerm_app_service_plan_name}-${random_integer.sample.result}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  kind     = "Linux"
  reserved = true # `reserved` has to be set to true when kind is set to `Linux`

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "this" {
  name                = "${var.azurerm_app_service_name}-${random_integer.sample.result}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id
  site_config {
    use_32_bit_worker_process = true # https://github.com/hashicorp/terraform-provider-azurerm/issues/1560
    dotnet_framework_version  = "v4.0"
    scm_type                  = "LocalGit"
  }

  # app_settings = {
  #   "SOME_KEY" = "some-value"
  # }

  # connection_string {
  #   name  = "Database"
  #   type  = "SQLServer"
  #   value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  # }

  depends_on = [azurerm_app_service_plan.this]
}
