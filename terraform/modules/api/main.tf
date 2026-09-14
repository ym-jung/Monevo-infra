locals {
  name = "monevo-${var.environment}"
}

resource "aws_apigatewayv2_api" "this" {
  name          = local.name
  protocol_type = "HTTP"
  tags          = var.tags

  dynamic "cors_configuration" {
    for_each = length(var.allowed_origins) > 0 ? [1] : []

    content {
      allow_origins     = var.allowed_origins
      allow_methods     = ["GET", "POST", "PATCH", "PUT", "DELETE", "OPTIONS"]
      allow_headers     = ["authorization", "content-type", "x-request-id", "x-client-version"]
      allow_credentials = false
      max_age           = 300
    }
  }
}

resource "aws_cloudwatch_log_group" "access" {
  name              = "/aws/apigateway/${local.name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
  tags        = var.tags

  default_route_settings {
    throttling_rate_limit  = var.throttle_rate_limit
    throttling_burst_limit = var.throttle_burst_limit
  }

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.access.arn
    format = jsonencode({
      requestId          = "$context.requestId"
      clientRequestId    = "$context.requestId"
      routeKey           = "$context.routeKey"
      status             = "$context.status"
      integrationStatus  = "$context.integration.status"
      responseLatency    = "$context.responseLatency"
      integrationLatency = "$context.integration.latency"
      ip                 = "$context.identity.sourceIp"
    })
  }
}
