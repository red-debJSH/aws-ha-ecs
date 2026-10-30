variable "name" {
  description = "Prefijo usado para nombrar los recursos de la VPC."
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el grupo de seguridad."
  type        = string
}

variable "front" {
  description = "Nombre del recurso para el front."
  type        = string
}

variable "back" {
  description = "Nombre del recurso para el back."
  type        = string
}
