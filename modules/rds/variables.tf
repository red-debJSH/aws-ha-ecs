variable "name" {
  description = "Prefijo usado para nombrar los recursos de la VPC."
  type        = string
}

variable "private_subnets" {
  description = "IDs de las subredes privadas, indexados por clave."
  type        = map(string)
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará la base de datos."
  type        = string
}

variable "username" {
  description = "Nombre de usuario para la base de datos."
  type        = string
}

variable "sg_name" {
  description = "Nombre del grupo de seguridad para la base de datos."
  type        = string
}

variable "backend_sg_id" {
  description = "ID del grupo de seguridad del backend que necesita acceso a la base de datos."
  type        = string
}