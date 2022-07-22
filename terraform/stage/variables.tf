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
  description = "Path to the private key used for ssh access"
}
variable image_id {
  description = "Disk image"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key.json"
}
variable instance_count {
  description = "count instances"
  default     = 1
}
variable "s3_access_key" {
  description = "Object storage access key"
}
variable "s3_secret_key" {
  description = "Object storage secret key"
}
variable "bucket_name" {
  description = "Name of backet"
}
variable enable_provision {
  description = "Enable provisioner"
  type        = bool
  default     = false
}
