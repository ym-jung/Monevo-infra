output "table_name" {
  description = "The environment's single DynamoDB table. Rate-limit counters are its only tenant so far."
  value       = aws_dynamodb_table.main.name
}

output "policy_arn" {
  description = "Policy every function role needs to count a request."
  value       = aws_iam_policy.counter.arn
}
