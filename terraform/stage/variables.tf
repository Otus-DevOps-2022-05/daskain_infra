variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable region_id {
  description = "region"
  default     = "ru-central1"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable image_id {
  description = "Disk image"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit_app_base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-image"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key .json"
}
variable instance_count {
  description = "count instances"
  default     = 1
}
