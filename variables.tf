variable "region" {
  type = string
  description = "Região para provisionar os recursos"
  default = ""
}

variable "profile" {
  type = string
  description = "Perfil com permissões para provisionar os recursos da AWS"
  default = ""
}

variable "ami" {
  description = "ID da AMI usada para provisionar a instância"
  default = ""
}

variable "instance_type" {
  description = "Tipo (classe) da instância"
  default = ""
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
  default     = ""
}

variable "cpu_credits" {
  description = "Opção de créditos de CPU da instância (\"unlimited\" ou \"standard\")"
  default     = ""
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "vpc_cidr_block" {
  default = ""
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "ebs_size" {
  description = "Lista com maps de configuração de volumes adicionais da instância"
}

variable security_groups {
  description = "SG atrelada a instance"
}