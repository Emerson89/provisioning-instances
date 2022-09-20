
variable "vpc_cidr_block" {
  description = "CIDR_block VPC"
}

variable "name" {
  description = "Nome da instância"
}
variable "vpc_id" {
  description = "VPC id da instancia"
}

#variable "ami" {
#  description = "ID da AMI usada para provisionar a instância"
#}

variable "subnet_id" {
  description = "Subnet da instancia"
}

variable "associate_public_ip_address" {
  description = "Ip public instance"
  default     = true
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22]
}

variable "egress_ports" {
  type        = list(number)
  description = "list of engress ports"
  default     = [0]
}

variable "instance_type" {
  description = "Tipo (classe) da instância"
  default     = "t3.micro"
}

variable "ebs_optimized" {
  description = "Controla se a instância será provisionada como EBS-optimized"
  default     = false
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
  type        = string
  description = "Nome do Key Pair a ser usado para a instância"
}

variable "cpu_credits" {
  description = "Opção de créditos de CPU da instância (\"unlimited\" ou \"standard\")"
  default     = "standard"
}

variable "ebs_block_device" {
  description = "Lista com maps de configuração de volumes adicionais da instância"
  type        = list(any)
  default     = []
}
