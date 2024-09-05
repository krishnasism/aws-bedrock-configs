data "aws_bedrock_foundation_model" "inference" {
  model_id = "amazon.titan-text-premier-v1:0"
}

data "aws_bedrock_foundation_model" "embeddings" {
  model_id = "amazon.titan-embed-text-v1"
}
