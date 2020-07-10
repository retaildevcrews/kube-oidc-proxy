provider "azurerm" {
    features {}
}

variable "azure_region" {
  default = "West US 2"
}

variable "cluster_version" {
  default = "1.15.12"
}

module "cluster" {
  source = "../modules/azure-cluster"
  suffix = "${random_id.suffix.hex}"

  cluster_version = "${var.cluster_version}"
  region          = "${var.azure_region}"
}

variable "ca_crt_file" {}
variable "ca_key_file" {}
