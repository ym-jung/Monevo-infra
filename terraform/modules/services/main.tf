locals {
  services = {
    meta = {
      memory_mb = 256
      route_keys = [
        "GET /api/v1/meta/{proxy+}",
      ]
    }

    user = {
      memory_mb = 512
      route_keys = [
        "ANY /api/v1/users/{proxy+}",
        "ANY /api/v1/admin/{proxy+}",
      ]
    }

    account = {
      memory_mb = 512
      route_keys = [
        "ANY /api/v1/accounts",
        "ANY /api/v1/accounts/{proxy+}",
        "ANY /api/v1/categories/{proxy+}",
        "ANY /api/v1/ledgers/{ledgerId}/categories",
      ]
    }

    report = {
      memory_mb = 512
      route_keys = [
        "GET /api/v1/ledgers/{ledgerId}/summary",
        "GET /api/v1/ledgers/{ledgerId}/analysis",
      ]
    }

    ledger = {
      memory_mb = 512
      route_keys = [
        "ANY /api/v1/ledgers",
        "ANY /api/v1/ledgers/{proxy+}",
        "ANY /api/v1/invites/{proxy+}",
      ]
    }

    journal = {
      memory_mb = 512
      route_keys = [
        "ANY /api/v1/journal-entries",
        "ANY /api/v1/journal-entries/{proxy+}",
      ]
    }
  }
}


module "kv" {
  source = "../kv"

  environment = var.environment
  tags        = var.tags
}

module "api" {
  source = "../api"

  environment          = var.environment
  throttle_rate_limit  = var.throttle_rate_limit
  throttle_burst_limit = var.throttle_burst_limit
  log_retention_days   = var.log_retention_days
  tags                 = var.tags
}

module "service" {
  source   = "../lambda-service"
  for_each = local.services

  name              = each.key
  environment       = var.environment
  api_id            = module.api.api_id
  api_execution_arn = module.api.api_execution_arn
  route_keys        = each.value.route_keys
  memory_mb         = each.value.memory_mb

  environment_variables = {
    DATABASE_URL_PARAMETER = var.database_url_parameter
    GATEWAY_SECRET         = data.aws_ssm_parameter.gateway_secret.value
    COGNITO_ISSUER         = var.cognito_issuer
    COGNITO_APP_CLIENT_ID  = var.cognito_app_client_id
    DYNAMODB_TABLE         = module.kv.table_name
    LOG_LEVEL              = var.log_level
    NODE_OPTIONS           = "--enable-source-maps"
  }

  extra_policy_arns = [module.kv.policy_arn, aws_iam_policy.read_database_url.arn]

  log_retention_days = var.log_retention_days
  tags               = var.tags
}

data "aws_ssm_parameter" "gateway_secret" {
  name            = var.gateway_secret_parameter
  with_decryption = true
}

data "aws_iam_policy_document" "read_database_url" {
  statement {
    actions   = ["ssm:GetParameter"]
    resources = ["arn:aws:ssm:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:parameter${var.database_url_parameter}"]
  }

  statement {
    actions   = ["kms:Decrypt"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["ssm.${data.aws_region.current.region}.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "read_database_url" {
  name   = "monevo-${var.environment}-read-database-url"
  policy = data.aws_iam_policy_document.read_database_url.json
  tags   = var.tags
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
