variable "environment" {
  description = "Environment slug, e.g. staging or prod."
  type        = string
}

variable "database_url_parameter" {
  description = "SSM parameter holding the Supabase transaction-mode URL, port 6543."
  type        = string
}



variable "gateway_secret_parameter" {
  description = "SSM parameter holding the shared secret the BFF sends. Without it a function cannot tell a proxied request from a direct one."
  type        = string
}

variable "cognito_issuer" {
  description = "https://cognito-idp.<region>.amazonaws.com/<pool id>"
  type        = string
}

variable "cognito_app_client_id" {
  description = "App client the access tokens are issued to."
  type        = string
}

variable "log_level" {
  description = "LOG_LEVEL the functions run with."
  type        = string
  default     = "info"
}

variable "log_retention_days" {
  description = "Retention for both lambda and access logs."
  type        = number
  default     = 30
}

variable "throttle_rate_limit" {
  description = "Steady-state requests per second across the stage."
  type        = number
  default     = 20
}

variable "throttle_burst_limit" {
  description = "Burst capacity across the stage."
  type        = number
  default     = 40
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
