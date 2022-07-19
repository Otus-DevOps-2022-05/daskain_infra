terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-rb"
    region     = "ru-central1"
    key        = "prod/terraform.tfstate"
    access_key = "YCAJE2I1buU6EgZWwQXX-ntrS"
    secret_key = "YCM7nhoN0VLYPjI6jclxsliiI6pfg-QZcDp7lZnt"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
