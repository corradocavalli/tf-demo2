
variable "resource_group_location" {
  type    = string
  default = "westeurope"
}

variable "developer_name" {
  type    = string
  default = "ccavalli"
}

//terraform apply -var "developer_name=jdoe"
//terraform.tfvars file (other name specified via -var-file flag)
//Environment variables
//TF_VAR_developer_name
