output "api_id" {
  description = "HTTP API id, passed to each lambda-service."
  value       = aws_apigatewayv2_api.this.id
}

output "api_execution_arn" {
  description = "Execution ARN, used for the lambda invoke permission."
  value       = aws_apigatewayv2_api.this.execution_arn
}

output "invoke_url" {
  description = "Stage URL. This is what BACKEND_API_URL and SERVICE_URL_* point at."
  value       = aws_apigatewayv2_stage.this.invoke_url
}

