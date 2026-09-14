variable "region" {
  description = "Region the lambdas, the API and the SSM parameter live in. Chosen to match Supabase and Amplify; the Cognito pool stays in us-east-1 and is not managed here."
  type        = string
  default     = "ap-northeast-1"
}

variable "database_url_parameter" {
  description = "SSM parameter holding the Supabase transaction-mode URL for prod."
  type        = string
  default     = "/monevo/prod/database-url"
}


variable "gateway_secret_parameter" {
  description = "SSM parameter holding the shared secret the BFF sends with every request."
  type        = string
  default     = "/monevo/prod/gateway-secret"
}

variable "cognito_issuer" {
  description = "https://cognito-idp.us-east-1.amazonaws.com/<pool id>"
  type        = string
}

variable "cognito_app_client_id" {
  description = "App client the access tokens are issued to."
  type        = string
}

