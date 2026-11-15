module "apis" {
  source     = "./modules/apis"
  project_id = var.project_id
}
module "identity" {
  source     = "./modules/identity"
  project_id = var.project_id
  name       = var.name
  depends_on = [module.apis]
}
module "registry" {
  source     = "./modules/registry"
  project_id = var.project_id
  region     = var.region
  name       = var.name
  depends_on = [module.apis]
}
module "agent" {
  count                 = var.deploy_agent ? 1 : 0
  source                = "./modules/agent"
  project_id            = var.project_id
  region                = var.region
  name                  = var.name
  image                 = var.agent_image
  service_account_email = module.identity.email
  model_id              = var.model_id
  vertex_location       = var.vertex_location
  invoker_members       = var.invoker_members
  max_instances         = var.max_instances
  deletion_protection   = var.deletion_protection
  depends_on            = [module.apis, module.identity, module.registry]
}
