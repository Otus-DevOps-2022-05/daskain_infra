variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "account_key_path" {
  description = "Path to the service account key file used for cloud access"
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
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}

