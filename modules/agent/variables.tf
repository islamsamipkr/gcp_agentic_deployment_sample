variable "project_id" { type = string }
variable "region" { type = string }
variable "name" { type = string }
variable "service_account_email" { type = string }
variable "image" {
  type = string
  validation {
    condition     = can(regex("^[a-z0-9-]+-docker\\.pkg\\.dev/.+@sha256:[a-f0-9]{64}$", var.image))
    error_message = "Supply a real Artifact Registry image pinned to a sha256 digest."
  }
}
variable "model_id" {
  type = string
  validation {
    condition     = length(trimspace(var.model_id)) > 0
    error_message = "Choose a model supported by your Vertex AI location."
  }
}
variable "vertex_location" { type = string }
variable "invoker_members" { type = set(string) }
variable "max_instances" { type = number }
variable "deletion_protection" { type = bool }
