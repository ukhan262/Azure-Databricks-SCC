output "main" {
  value = azurerm_private_endpoint.main
}

output "private_service_connections" {
  value = azurerm_private_endpoint.main.private_service_connection
}