variable "name" {
  description = "Prefijo usado para nombrar los recursos de la VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR IPv4 de la VPC."
  type        = string
}

variable "public_subnets" {
  description = "Subredes públicas indexadas por una clave estable."
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Subredes privadas indexadas por una clave estable que coincide con public_subnets."
  type = map(object({
    cidr = string
    az   = string
  }))
}