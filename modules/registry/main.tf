variable "project_id" { type = string }
variable "region" { type = string }
variable "name" { type = string }
resource "google_artifact_registry_repository" "images" {
  project       = var.project_id
  location      = var.region
  repository_id = var.name
  format        = "DOCKER"
  description   = "Versioned agent application images"
  docker_config { immutable_tags = true }
}
output "url" {
  value = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.images.repository_id}"
}
