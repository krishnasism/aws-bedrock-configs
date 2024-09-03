data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "bedrock_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["bedrock.amazonaws.com"]
      type        = "Service"
    }
    condition {
      test     = "StringEquals"
      values   = [data.aws_caller_identity.current.account_id]
      variable = "aws:SourceAccount"
    }
    condition {
      test     = "ArnLike"
      values   = ["arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:agent/*"]
      variable = "AWS:SourceArn"
    }
  }
}

data "aws_iam_policy_document" "bedrock_permissions" {
  statement {
    actions = ["bedrock:InvokeModel"]
    resources = [
      "arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}::foundation-model/anthropic.claude-v2",
    ]
  }
}

resource "aws_iam_role" "bedrock" {
  assume_role_policy = data.aws_iam_policy_document.bedrock_trust.json
  name_prefix        = "AmazonBedrockExecutionRoleForAgents_"
}

resource "aws_iam_role_policy" "bedrock" {
  policy = data.aws_iam_policy_document.bedrock_permissions.json
  role   = aws_iam_role.bedrock.id
}

resource "aws_bedrockagent_agent" "bedrock" {
  agent_name                  = "bedrock"
  agent_resource_role_arn     = aws_iam_role.bedrock.arn
  idle_session_ttl_in_seconds = 500
  foundation_model            = data.aws_bedrock_foundation_model.inference.model_name
}

resource "aws_bedrockagent_data_source" "bedrock" {
  knowledge_base_id = "bedrock-foo-111"
  name              = "bedrock"
  data_source_configuration {
    type = "S3"
    s3_configuration {
      bucket_arn = aws_s3_bucket.source.arn
    }
  }
}