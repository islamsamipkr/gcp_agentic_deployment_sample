variable "project_id" { type = string }
variable "name" { type = string }
resource "google_service_account" "runtime" {
  project      = var.project_id
  account_id   = var.name
  display_name = "Serverless agent runtime"
}
# Additive IAM membership: does not overwrite the project's other role members.
# This predefined role is broader than inference-only permissions. Review a
# custom role against your agent's actual API calls before production use.
resource "google_project_iam_member" "vertex" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.runtime.email}"
}
output "email" { value = google_service_account.runtime.email }
