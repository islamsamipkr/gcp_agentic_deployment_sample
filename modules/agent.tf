resource "google_cloud_run_v2_service" "agent" {
  project             = var.project_id
  location            = var.region
  name                = var.name
  deletion_protection = var.deletion_protection
  # Publicly routable HTTPS endpoint, protected by Cloud Run IAM.
  # This is NOT private-network ingress.
  ingress = "INGRESS_TRAFFIC_ALL"
  template {
    service_account                  = var.service_account_email
    timeout                          = "300s"
    max_instance_request_concurrency = 8
    scaling {
      min_instance_count = 0
      max_instance_count = var.max_instances
    }
    containers {
      image = var.image
      ports { container_port = 8080 }
      resources {
        limits            = { cpu = "1", memory = "1Gi" }
        cpu_idle          = true
        startup_cpu_boost = true
      }
      dynamic "env" {
        for_each = {
          GOOGLE_GENAI_USE_VERTEXAI = "true"
          GOOGLE_CLOUD_PROJECT      = var.project_id
          GOOGLE_CLOUD_LOCATION     = var.vertex_location
          MODEL_ID                  = var.model_id
        }
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }
}
resource "google_cloud_run_v2_service_iam_member" "invoker" {
  for_each = var.invoker_members
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.agent.name
  role     = "roles/run.invoker"
  member   = each.value
}
output "url" { value = google_cloud_run_v2_service.agent.uri }
