variable "environment" {
  description = "Environment slug, e.g. staging or prod."
  type        = string
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
