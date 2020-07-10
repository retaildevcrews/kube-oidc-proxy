variable "region" {}
variable "suffix" {}
variable "cluster_version" {}

locals {
  cluster_name = "cluster-${var.suffix}"
}

resource "azurerm_resource_group" "cluster-rg" {
  name     = "cluster-${var.suffix}"
  location = "${var.region}"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "cluster-${var.suffix}"
  location            = azurerm_resource_group.cluster-rg.location
  resource_group_name = azurerm_resource_group.cluster-rg.name
  dns_prefix          = "cluster-${var.suffix}"
  kubernetes_version = "${var.cluster_version}"


  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}
