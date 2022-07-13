variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-image"
}
variable subnet_id {
  description = "Subnet"
}
variable private_key_path {
  description = "path to private key"
}
variable enable_provision {
  description = "Enable provisioner"
  default     = true
}
