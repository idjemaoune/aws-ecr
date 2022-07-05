output "name" {
  value = aws_ecr_repository.repository.name
  description = "The name of the repository."
}

output "registry_id" {
  value = aws_ecr_repository.repository.registry_id
  description = "The registry ID of the repository"
}

output "repository_url" {
  value = aws_ecr_repository.repository.repository_url
  description = "The URL of the repository"
}
