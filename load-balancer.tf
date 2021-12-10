
resource "azurerm_lb" "mylb" {
   name                = "myloadBalancer"
   location            = azurerm_resource_group.myrg.location
   resource_group_name = azurerm_resource_group.myrg.name

   frontend_ip_configuration {
     name                 = "publicIPAddress"
     public_ip_address_id = azurerm_public_ip.mypip.id
   }
 }

 resource "azurerm_lb_backend_address_pool" "mybepool" {
   loadbalancer_id     = azurerm_lb.mylb.id
   name                = "BackEndAddressPool"
 }