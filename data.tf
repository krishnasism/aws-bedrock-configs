data "aws_bedrock_foundation_model" "inference" {
  model_id = "amazon.titan-text-express-v1"
}

data "aws_bedrock_foundation_model" "embeddings" {
  model_id = "cohere.embed-english-v3"
}
