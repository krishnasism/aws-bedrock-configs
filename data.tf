data "aws_bedrock_foundation_model" "inference" {
  model_id = "amazon.titan-text-premier-v1:0"
}

data "aws_bedrock_foundation_model" "embeddings" {
  model_id = "cohere.embed-english-v3"
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "bedrock_trust" {
  statement {
    effect  = "Allow"
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
      test = "ArnLike"
      values = [
        "arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:agent/*",
        "arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:knowledge-base/*",
      ]
      variable = "AWS:SourceArn"
    }
  }
}

data "aws_iam_policy_document" "bedrock_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "bedrock:InvokeModel",
      "bedrock:CreateKnowledgeBase",
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}::foundation-model/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "bedrock:ListFoundationModels",
      "bedrock:ListCustomModels",
      "bedrock:RetrieveAndGenerate"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/*",
      "arn:aws:s3:::${local.s3_bucket_name}*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "aoss:APIAccessAll"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:aoss:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:collection/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
    ]
  }
}
