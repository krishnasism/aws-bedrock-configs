resource "aws_bedrockagent_data_source" "bedrock" {
  knowledge_base_id = aws_bedrockagent_knowledge_base.bedrock.id
  name              = "bedrock"
  data_source_configuration {
    type = "S3"
    s3_configuration {
      bucket_arn = aws_s3_bucket.source.arn
    }
  }
}
