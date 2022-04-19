
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}

variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}

variable "network_id" {
  description = "Network ID"
  default     = "enp3rhvqq13h969vdlks"
}
variable "subnet_id" {
  description = "Subnet"
  default     = "e9bs9omgumraqpam9o1i"
}
variable "name_template" {
  type = string
  description = "Name template"
}
