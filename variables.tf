variable "project_id" { type = string }
variable "region" {
  type    = string
  default = "us-central1"
}
variable "name" {
  type    = string
  default = "agent-runtime"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.name))
    error_message = "Use 6-30 lowercase letters, digits or hyphens; start with a letter and end with a letter or digit."
  }
}
variable "deploy_agent" {
  type    = bool
  default = false
}
variable "agent_image" {
  type        = string
  default     = ""
  description = "Existing Artifact Registry image pinned by sha256 digest."
}
variable "model_id" {
  type        = string
  default     = ""
  description = "A Gemini model available to your project at vertex_location; the application must read MODEL_ID."
}
variable "vertex_location" {
  type    = string
  default = "us-central1"
}
variable "invoker_members" {
  type        = set(string)
  default     = []
  description = "Explicit IAM callers, e.g. serviceAccount:caller@project.iam.gserviceaccount.com."
  validation {
    condition     = alltrue([for m in var.invoker_members : can(regex("^(user|group|serviceAccount):.+", m))])
    error_message = "Provide explicit user:, group: or serviceAccount: principals; public grants are disallowed."
  }
}
variable "max_instances" {
  type    = number
  default = 5
  validation {
    condition     = var.max_instances >= 1 && floor(var.max_instances) == var.max_instances
    error_message = "max_instances must be a positive integer."
  }
}
variable "deletion_protection" {
  type    = bool
  default = true
}
