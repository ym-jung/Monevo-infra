output "invoke_url" {
  description = "Stage URL. Set every SERVICE_URL_* on the Amplify branch to this."
  value       = module.services.invoke_url
}

output "function_names" {
  description = "Function names CI deploys code to."
  value       = module.services.function_names
}
