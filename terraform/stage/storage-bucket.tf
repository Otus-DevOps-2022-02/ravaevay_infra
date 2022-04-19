terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "ravaevay-infra"
    region     = "ru-central1"
    key        = "terraform_bucket/prod.tfstate"
    access_key = "YCAJEylpPtxRqcXTWSS67Ssw9"
    secret_key = "YCPKfyd59i0wg85HDE86sLtR7s-pwL9GPXVBYeFo"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
