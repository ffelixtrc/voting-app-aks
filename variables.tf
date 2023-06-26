variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Localização do  Grupo de Recursos"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefixo do nome do grupo de recursos que é combinado com uma ID aleatória para que o nome seja exclusivo em sua assinatura do Azure"
}

variable "node_count" {
  type        = number
  description = "Quantidade inicial de nós do Pool"
  default     = 3
}

