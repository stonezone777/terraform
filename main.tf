_**Advanced Project: Multi-Cloud Web Application**_

_**main.tf**_

```terraform
# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a resource group in Azure
resource "azurerm_resource_group" "main" {
  name     = "my-terraform-rg"
  location = "East US"
}

# Create a virtual network in Azure
resource "azurerm_virtual_network" "main" {
  name                = "my-terraform-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Create a subnet in Azure
resource "azurerm_subnet" "main" {
  name                 = "my-terraform-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a web server in AWS
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
  instance_type = "t2.micro"

  tags = {
    Name = "My Multi-Cloud Web Server"
  }
}

# Create a database in Azure
resource "azurerm_mysql_server" "main" {
  name                = "my-terraform-mysql-server"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku_name = "B_Gen5_1"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "mysqladmin"
  administrator_login_password = "Password1234!"
  version                      = "8.0"
  ssl_enforcement_enabled      = true
}
```
