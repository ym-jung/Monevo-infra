output "function_name" {
  description = "Name CI passes to aws lambda update-function-code."
  value       = aws_lambda_function.this.function_name
}

output "role_name" {
  description = "IAM role, for attaching extra policies from the environment."
  value       = aws_iam_role.this.name
}
