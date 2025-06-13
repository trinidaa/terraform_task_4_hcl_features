output "combined_tags" {
  description = "concatenated tags for all VMs"
  value = [
    for vm in azurerm_virtual_machine.main :
    join(", ", [for key, value in vm.tags : "${key}=${value}"])
  ]
}
output "uppercase_vm_names" {
  description = "Names of all VMs in uppercase"
  value       = { for vm in azurerm_virtual_machine.main : vm.name => upper(vm.name) }
}

output "all_vm_ids" {
  description = "IDs of all VMs"
  value = { for k, vm in azurerm_virtual_machine.main : "vm-${tonumber(k) + 1}" => vm.id
  }
}