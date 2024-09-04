data "aws_bedrock_foundation_model" "inference" {
  model_id = "amazon.titan-text-premier-v1:0"
}

data "aws_bedrock_foundation_model" "embeddings" {
  model_id = "cohere.embed-english-v3"
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}
