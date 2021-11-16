variable "ami" {
  description = "ID da AMI usada para provisionar a instância"
  default = ""
}

variable "instance_type" {
  description = "Tipo (classe) da instância"
  default = ""
}

variable "ebs_optimized" {
  description = "Controla se a instância será provisionada como EBS-optimized"
  default     = false
}

variable "name" {
  description = "Nome da instância"
}

variable "tags" {
  description = "Map de tags da instância e dos volumes"
  default     = {}
}

variable "instance_count" {
  description = "Número de instâncias que serão provisionadas"
  default     = 1
}

variable "key_name" {
  type = string
  description = "Nome do Key Pair a ser usado para a instância"
  default     = "key"
}

variable "cpu_credits" {
  description = "Opção de créditos de CPU da instância (\"unlimited\" ou \"standard\")"
  default     = ""
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "ebs_block_device" {
  description = "Lista com maps de configuração de volumes adicionais da instância"
  type        = list
  default     = []
}

variable security_groups {
  description = "SG atrelada a instance"
}