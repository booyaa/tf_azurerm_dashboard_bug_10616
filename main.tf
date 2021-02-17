# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.47.0"
  features {}
}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "my-group" {
  name     = "mygroup"
  location = "uksouth"
}

resource "azurerm_dashboard" "my-board" {
  name                = "my-cool-dashboard"
  resource_group_name = azurerm_resource_group.my-group.name
  location            = azurerm_resource_group.my-group.location
  tags = {
    source = "terraform"
  }
  dashboard_properties = templatefile("dash.tpl",
    {
      md_content = "__My data2__"
  })
}
