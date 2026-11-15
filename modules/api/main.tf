variable "project_id" { type = string }
resource "google_project_service" "required" {
  for_each = toset([
    "serviceusage.googleapis.com", "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com", "run.googleapis.com", "aiplatform.googleapis.com",
    "artifactregistry.googleapis.com", "logging.googleapis.com", "monitoring.googleapis.com"
  ])
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
