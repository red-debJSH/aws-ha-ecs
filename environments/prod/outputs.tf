output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ecr_url" {
  value = module.ecr.ecr_url
}

output "ecr_back_url" {
  value = module.ecr-back.ecr_url
}

output "password_db" {
  value     = module.rds.db_password
  sensitive = true
}

output "username_db" {
  value = module.rds.db_username
}