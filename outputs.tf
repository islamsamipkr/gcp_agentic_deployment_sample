output "repository_url" { value = module.registry.url }
output "runtime_service_account" { value = module.identity.email }
output "agent_url" { value = try(module.agent[0].url, null) }
