output "id" {
    value  = [for x in azurerm_private_dns_zone.dnsz : x.id]
}