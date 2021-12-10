
resource "azurerm_virtual_machine" "myvm" {
   count                 = "${var.machinecount}"
   name                  = "cluster-vm-${count.index}"
   location              = azurerm_resource_group.myrg.location
   resource_group_name   = azurerm_resource_group.myrg.name
   availability_set_id   = azurerm_availability_set.myavset.id
   network_interface_ids = [element(azurerm_network_interface.mynic.*.id, count.index)]
   vm_size               = "Standard_B1s"
   delete_os_disk_on_termination = true
   delete_data_disks_on_termination = true

   # Uncomment this line to delete the OS disk automatically when deleting the VM
   # delete_os_disk_on_termination = true

   # Uncomment this line to delete the data disks automatically when deleting the VM
   # delete_data_disks_on_termination = true

   storage_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "16.04-LTS"
     version   = "latest"
   }

   storage_os_disk {
     name              = "myosdisk${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
   }

   # Optional data disks
   storage_data_disk {
     name              = "datadisk_new_${count.index}"
     managed_disk_type = "Standard_LRS"
     create_option     = "Empty"
     lun               = 0
     disk_size_gb      = "1023"
   }

   storage_data_disk {
     name            = element(azurerm_managed_disk.mydisks.*.name, count.index)
     managed_disk_id = element(azurerm_managed_disk.mydisks.*.id, count.index)
     create_option   = "Attach"
     lun             = 1
     disk_size_gb    = element(azurerm_managed_disk.mydisks.*.disk_size_gb, count.index)
   }

   os_profile {
     computer_name  = "cluster-vms"
     admin_username = "adminuser"
     admin_password = "Passw0rd@123"
   }

   os_profile_linux_config {
     disable_password_authentication = false
   }

   tags = {
     environment = "${var.env}"
   }
 }