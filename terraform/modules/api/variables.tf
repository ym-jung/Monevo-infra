variable "environment" {
  description = "Environment slug, e.g. staging or prod."
  type        = string
}

variable "allowed_origins" {
  description = "CORS origins. Empty keeps CORS off, which is correct while the BFF is the only caller."
  type        = list(string)
  default     = []
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

variable "log_retention_days" {
  description = "Access log retention."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}


