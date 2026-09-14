variable "name" {
  description = "Service name, used for the function name and log group."
  type        = string
}

variable "environment" {
  description = "Environment slug, e.g. staging or prod."
  type        = string
}

variable "api_id" {
  description = "HTTP API the routes are attached to."
  type        = string
}

variable "api_execution_arn" {
  description = "Execution ARN of the HTTP API, for the invoke permission."
  type        = string
}

variable "route_keys" {
  description = "API Gateway route keys this service answers, e.g. ANY /api/v1/accounts/{proxy+}."
  type        = list(string)
}

variable "environment_variables" {
  description = "Environment the function runs with."
  type        = map(string)
  default     = {}
}

variable "memory_mb" {
  description = "Memory size, which also sets the CPU share."
  type        = number
  default     = 512
}

variable "timeout_seconds" {
  description = "Function timeout. Must exceed the slowest upstream call."
  type        = number
  default     = 15
}

variable "log_retention_days" {
  description = "CloudWatch log retention. Logs are the only thing here that accrues cost while idle."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}

variable "extra_policy_arns" {
  description = "Policies attached on top of the basic execution role."
  type        = list(string)
  default     = []
}



