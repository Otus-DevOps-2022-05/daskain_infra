variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-image"
}
variable subnet_id {
  description = "Subnet"
}
variable enable_provision {
  description = "Enable provisioner"
  default     = true
}
variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}
variable mongod_ip {
  description = "Mongodb IP"
}
