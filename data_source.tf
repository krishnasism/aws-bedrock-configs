resource "aws_bedrockagent_data_source" "bedrock" {
  knowledge_base_id = aws_bedrockagent_knowledge_base.bedrock.id
  name              = "bedrock"
  data_source_configuration {
    type = "S3"
    s3_configuration {
      bucket_arn = aws_s3_bucket.source.arn
    }
  }
  vector_ingestion_configuration {
    chunking_configuration {
      chunking_strategy = "FIXED_SIZE"
      fixed_size_chunking_configuration {
        max_tokens         = 1536
        overlap_percentage = 20
      }
    }
  }
}
