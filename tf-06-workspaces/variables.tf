
variable "resource_group_name" {
  type    = string
  default = "rg-cp-nebula"
}

variable "loc_prefix" {
  type = map(string)
  default = {
    dev  = "weu"
    prod = "eus"
  }
}

variable "locations" {
  type = map(string)
  default = {
    dev  = "westeurope"
    prod = "eastus"
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "cpdata"
}

variable "devname" {
  type    = string
  default = "ccavalli"
}
