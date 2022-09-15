variable "prefix" {
  type        = string
  description = "resource name"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "northcentralus"
}

variable "subnet_id" {
  type = string
}

variable "subresource_names" {
  type    = list(string)
  default = []
}

variable "private_connection_resource_id" {
  type = string
}

### tagging
variable "additional_tags" {
  type    = map(any)
  default = {}
}

variable "environment" {
  type    = string
  default = "eval"
}

variable "tier" {
  type    = string
  default = "data"
}

variable "infra" {
  type    = string
  default = "yes"
}

variable "cost_center" {
  type    = string
  default = "9575"
}

variable "data" {
  type    = string
  default = ""
}

variable "regulatory" {
  type    = string
  default = ""
}

variable "owner" {
  type    = string
  default = ""
}

variable "private_dns_zone_group" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      name                 = string
      private_dns_zone_ids = list(string)
    }
  ))
  default = []
}