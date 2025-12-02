terraform{
    required_version= ">=1.0"
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = ">=3.0"
      }
    }
}

provider "azurerm"{
    features {}
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "main" {
  name = "${var.resource_group_name}RG${var.env_name}"
  location = var.region_name
  tags = { 
    CreatedDate=timestamp()
    ManagedBy = "Terraform"
    Project = var.project_name
    Environment = var.env_name
    }
}

resource "azurerm_storage_account" "main" {
  name = "${var.storage_account_name}9381"
  resource_group_name = azurerm_resource_group.main.name
  location = var.region_name
  account_tier = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
}

resource "azurerm_storage_account_static_website" "main" {
  storage_account_id = azurerm_storage_account.main.id
  
  index_document     = "index.html"
  error_404_document = "error.html"
}

resource "azurerm_storage_blob" "index" {
    name="index.html"
  storage_account_name = azurerm_storage_account.main.name
  storage_container_name =  "$web"
  source="website_files/index.html"
  type = "Block"
  content_type = "text/html"
  depends_on = [azurerm_storage_account_static_website.main]
}

resource "azurerm_storage_blob" "error" {
    name="error.html"
  storage_account_name = azurerm_storage_account.main.name
  storage_container_name = "$web"
  source="website_files/error.html"
  type = "Block"
  content_type = "text/html"
  depends_on = [azurerm_storage_account_static_website.main]
}