output "vpc_id" {
  description = "ID de la VPC creada."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas, indexados por clave."
  value       = { for key, subnet in aws_subnet.public : key => subnet.id }
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas, indexados por clave."
  value       = { for key, subnet in aws_subnet.private : key => subnet.id }
}