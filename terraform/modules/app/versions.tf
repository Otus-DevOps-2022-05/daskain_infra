terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
