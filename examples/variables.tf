variable "aws_region" {
  type        = string
  description = "Região para provisionar os recursos"
  default     = "us-east-1"
}

variable "profile" {
  type        = string
  description = "Perfil com permissões para provisionar os recursos da AWS"
  default     = "local"
}