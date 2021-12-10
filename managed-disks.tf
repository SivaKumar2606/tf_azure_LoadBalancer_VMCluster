
resource "azurerm_managed_disk" "mydisks" {
   count                = "${var.machinecount}"
   name                 = "datadisk_existing_${count.index}"
   location            = azurerm_resource_group.myrg.location
   resource_group_name = azurerm_resource_group.myrg.name
   storage_account_type = "Standard_LRS"
   create_option        = "Empty"
   disk_size_gb         = "1023"
 }