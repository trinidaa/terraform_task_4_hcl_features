resource "azurerm_virtual_machine" "main" {
  count               = var.is_prod ? var.prod_vm : 2
  name                = "${var.prefix}-vm-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_interface_ids = [
    azurerm_network_interface.main[count.index * 2].id,
    azurerm_network_interface.main[count.index * 2 + 1].id
  ]
  primary_network_interface_id = azurerm_network_interface.main[count.index * 2].id
  vm_size                       = "Standard_D2s_v6"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  storage_os_disk {
    name              = "osdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
    costcenter  = "it"
    project     = "task4"
  }
  lifecycle {
    create_before_destroy = true
  }
}