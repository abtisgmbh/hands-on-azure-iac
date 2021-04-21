output "connection_string" {
  description = "Use this string to connect via SSH to the newly created vm"
  value       = "ssh -o 'IdentitiesOnly=yes' -i ./${local_file.this.filename} ${var.username}@${azurerm_public_ip.this.ip_address}"
}