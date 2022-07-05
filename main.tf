resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = var.immutable ? "IMMUTABLE" : "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  tags = merge(
    var.global_tags,
    {
      "Mutability"  = "${var.immutable}"
      "ScannOnPush" = "${var.scan_on_push}"
    },
  )
}


locals {
  policy_enabled = length(var.repository_policy_statements) > 0 || length(var.push_identities) > 0 || length(var.pull_identities) > 0

  ecr_pull_actions = [
    "ecr:BatchCheckLayerAvailability",
    "ecr:BatchGetImage",
    "ecr:GetDownloadUrlForLayer",
  ]

  ecr_push_actions = [
    "ecr:BatchCheckLayerAvailability",
    "ecr:CompleteLayerUpload",
    "ecr:InitiateLayerUpload",
    "ecr:ListImages",
    "ecr:PutImage",
    "ecr:UploadLayerPart",
  ]

  push_statement = length(var.push_identities) > 0 ? [{
    actions     = local.ecr_push_actions
    identifiers = var.push_identities
  }] : []

  pull_statement = length(var.pull_identities) > 0 ? [{
    actions     = local.ecr_pull_actions
    identifiers = var.pull_identities
  }] : []
}

data "aws_iam_policy_document" "policy" {
  count = local.policy_enabled ? 1 : 0

  dynamic "statement" {
    for_each = var.repository_policy_statements

    content {
      actions = try(statement.value.actions, null)
      effect  = try(statement.value.effect, null)
      sid     = try(statement.value.sid, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = try(principals.value.type, "AWS")
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = try(not_principals.value.type, "AWS")
          identifiers = not_principals.value.identifiers
        }
      }
    }
  }

  dynamic "statement" {
    for_each = concat(local.pull_statement, local.push_statement)

    content {
      actions = statement.value.actions
      effect  = "Allow"
      principals {
        type        = "AWS"
        identifiers = statement.value.identifiers
      }
    }
  }
}

resource "aws_ecr_repository_policy" "repository_policy" {
  count = local.policy_enabled ? 1 : 0

  repository = try(aws_ecr_repository.repository.name, null)
  policy     = join("", data.aws_iam_policy_document.policy.*.json)
}

locals {
  lifecycle_policy = jsonencode({
    rules = var.lifecycle_policy_rules
  })
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  count = length(var.lifecycle_policy_rules) > 0 ? 1 : 0

  repository = try(aws_ecr_repository.repository.name, null)
  policy     = local.lifecycle_policy
}
