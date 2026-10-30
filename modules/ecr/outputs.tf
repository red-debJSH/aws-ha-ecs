output "ecr_url" {
  description = "URL del repositorio ECR creado."
  value       = aws_ecr_repository.ecr.repository_url

}