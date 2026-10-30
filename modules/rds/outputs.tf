output "db_subnet_group_id" {
  description = "ID del grupo de subredes de la base de datos."
  value       = aws_db_subnet_group.rds_subnet_group.id
}

output "db_password" {
  description = "Contraseña generada para la base de datos."
  value       = random_password.rds_password.result
}

output "db_username" {
  description = "Nombre de usuario de la base de datos."
  value       = var.username
}