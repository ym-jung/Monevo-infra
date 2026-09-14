module "services" {
  source = "../../modules/services"

  environment              = "prod"
  database_url_parameter   = var.database_url_parameter
  gateway_secret_parameter = var.gateway_secret_parameter
  cognito_issuer           = var.cognito_issuer
  cognito_app_client_id    = var.cognito_app_client_id
}
