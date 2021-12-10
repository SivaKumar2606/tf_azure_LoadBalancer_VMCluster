
resource "azurerm_virtual_network" "myvnet" {
   name                = "${var.vnet_name}"
   address_space       = ["${var.vnet_cidr}"]
   location            = azurerm_resource_group.myrg.location
   resource_group_name = azurerm_resource_group.myrg.name
}

  
 resource "azurerm_subnet" "mysubnet" {
   name                 = "${var.subnet_name}"
   resource_group_name  = azurerm_resource_group.myrg.name
   virtual_network_name = azurerm_virtual_network.myvnet.name
   address_prefixes     = ["${var.subnet_cidr}"]
}


 resource "azurerm_public_ip" "mypip" {
   name                         = "mypip"
   location                     = azurerm_resource_group.myrg.location
   resource_group_name          = azurerm_resource_group.myrg.name
   allocation_method            = "Static"
}

 resource "azurerm_network_interface" "mynic" {
   count               = "${var.machinecount}"
   name                = "cluster-${count.index}"
   location            = azurerm_resource_group.myrg.location
   resource_group_name = azurerm_resource_group.myrg.name

   ip_configuration {
     name                          = "testConfiguration"
     subnet_id                     = azurerm_subnet.mysubnet.id
     private_ip_address_allocation = "dynamic"
   }
}

resource "azurerm_availability_set" "myavset" {
   name                         = "myavset"
   location                     = azurerm_resource_group.myrg.location
   resource_group_name          = azurerm_resource_group.myrg.name
   platform_fault_domain_count  = 3
   platform_update_domain_count = 5
   managed                      = true
}
