output "invoke_url" {
  description = "Stage URL every SERVICE_URL_* points at."
  value       = module.api.invoke_url
}

output "service_urls" {
  description = "The SERVICE_URL_* values to set on the Amplify branch."
  value       = { for name, _ in local.services : upper(name) => module.api.invoke_url }
}

output "function_names" {
  description = "Function names CI deploys code to."
  value       = { for name, service in module.service : name => service.function_name }
}
