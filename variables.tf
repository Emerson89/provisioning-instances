variable "region" {
  type        = string
  description = "Região para provisionar os recursos"
}

variable "profile" {
  type        = string
  description = "Perfil com permissões para provisionar os recursos da AWS"
}

variable "ami" {
  description = "ID da AMI usada para provisionar a instância"
}

variable "name" {
  description = "Nome da instância"
}

variable "key_name" {
  type        = string
  description = "Nome do Key Pair a ser usado para a instância"
}

variable "vpc_id" {
  description = "VPC id da instancia"
}

variable "vpc_cidr_block" {
  description = "CIDR_block VPC"
}

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

variable "tags" {
  description = "Map de tags da instância e dos volumes"
  default     = {}
}

variable "instance_count" {
  description = "Número de instâncias que serão provisionadas"
  default     = 1
}


variable "cpu_credits" {
  description = "Opção de créditos de CPU da instância (\"unlimited\" ou \"standard\")"
  default     = "standard"
}

variable "ebs_size" {
  description = "Lista com maps de configuração de volumes adicionais da instância"
  default     = 8
}

variable "dev" {
  description = "Name device volume ebs"
  default     = "/dev/sda1"
}

variable "type" {
  description = "Type de volume ebs"
  default     = "gp2"
}