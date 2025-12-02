output "website_endpoint" {
  description = "Primary web endpoint for static website"
  value       = azurerm_storage_account.main.primary_web_endpoint
}

output "website_host" {
  description = "Primary web host for static website"
  value       = azurerm_storage_account.main.primary_web_host
}