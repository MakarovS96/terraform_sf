terraform {
  required_version = " >= 1.5"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.105.0"
    }
  }
}

provider "yandex" {
  token                    = file("../keys/token")
  cloud_id                 = var.cloud
  folder_id                = var.folder
  zone                     = var.zone
}

resource "yandex_iam_service_account" "sa" {
  name = "sfman"
  folder_id = var.folder
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on = [ yandex_iam_service_account.sa ]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
  depends_on = [ yandex_iam_service_account.sa ]
}

resource "yandex_storage_bucket" "state" {
  bucket     = "bucket-for-tf-state"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  depends_on = [ yandex_iam_service_account_static_access_key.sa-static-key ]
}

resource "null_resource" "save_keys" {
  triggers = {
    "key" = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  }

  provisioner "local-exec" {
    command = "echo ${yandex_iam_service_account_static_access_key.sa-static-key.access_key} > ../keys/access_key & echo ${yandex_iam_service_account_static_access_key.sa-static-key.secret_key} > ../keys/secret_key"
  }
}