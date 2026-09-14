resource "aws_dynamodb_table" "main" {
  name         = "monevo-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  tags = var.tags
}

data "aws_iam_policy_document" "counter" {
  statement {
    actions   = ["dynamodb:UpdateItem"]
    resources = [aws_dynamodb_table.main.arn]
  }
}

resource "aws_iam_policy" "counter" {
  name   = "monevo-${var.environment}-rate-limit"
  policy = data.aws_iam_policy_document.counter.json
  tags   = var.tags
}
