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
        max_tokens         = 512
        overlap_percentage = 20
      }
    }
  }
}

resource "aws_bedrockagent_knowledge_base" "bedrock" {
  name     = "bedrock"
  role_arn = aws_iam_role.bedrock.arn

  knowledge_base_configuration {
    vector_knowledge_base_configuration {
      embedding_model_arn = data.aws_bedrock_foundation_model.embeddings.model_arn
    }
    type = "VECTOR"
  }

  storage_configuration {
    type = "OPENSEARCH_SERVERLESS"
    opensearch_serverless_configuration {
      collection_arn    = aws_opensearchserverless_collection.bedrock.arn
      vector_index_name = var.vector_index
      field_mapping {
        vector_field   = var.vector_field
        text_field     = "AMAZON_BEDROCK_TEXT_CHUNK"
        metadata_field = "AMAZON_BEDROCK_METADATA"
      }
    }
  }
}

resource "aws_bedrockagent_agent_knowledge_base_association" "bedrock" {
  agent_id             = aws_bedrockagent_agent.bedrock.id
  description          = "Knowledge Base"
  knowledge_base_id    = aws_bedrockagent_knowledge_base.bedrock.id
  knowledge_base_state = "ENABLED"
}
