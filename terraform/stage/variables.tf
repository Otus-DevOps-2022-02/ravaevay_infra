variable "cloud_id" {
  description = "Cloud"
  default     = "b1gd49j0hgugak1q88cn"
}
variable "folder_id" {
  description = "Folder"
  default     = "b1guqoie8egj4nbnr4da"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}
variable "image_id" {
  description = "Disk image"
  default     = "fd85hkvj3s2ip81ofabq"
}
variable "network_id" {
  description = "Network ID"
  default     = "enp3rhvqq13h969vdlks"
}
variable "subnet_id" {
  description = "Subnet"
  default     = "e9bs9omgumraqpam9o1i"
}
variable "service_account_key_file" {
  description = "key .json"
  default     = "/home/rai/compose-scripts/Otus-Study/HW-2/ravaevay_infra/key.json"
}
variable "private_key_path" {
  description = "Path to private key"
  # default     = "~/.ssh/appuser"
}
variable "counter" {
  type    = number
  default = 1
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable "name_template" {
  type        = string
  description = "Name template"
}
