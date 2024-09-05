resource "aws_opensearchserverless_collection" "bedrock" {
  name = "bedrock"
  type = "VECTORSEARCH"
  depends_on = [
    aws_opensearchserverless_security_policy.encryption,
    aws_opensearchserverless_security_policy.network,
    aws_opensearchserverless_access_policy.bedrock,
  ]
  standby_replicas = "DISABLED"
}

resource "opensearch_index" "bedrock" {
  name                           = var.vector_index
  number_of_shards               = "1"
  number_of_replicas             = "0"
  index_knn                      = true
  index_knn_algo_param_ef_search = "512"
  mappings                       = <<-EOF
    {
      "properties": {
        "${var.vector_field}": {
          "type": "knn_vector",
          "dimension": 1536,
          "method": {
            "name": "hnsw",
            "engine": "faiss",
            "parameters": {
              "m": 16,
              "ef_construction": 512
            },
            "space_type": "l2"
          }
        },
        "AMAZON_BEDROCK_METADATA": {
          "type": "text",
          "index": "false"
        },
        "AMAZON_BEDROCK_TEXT_CHUNK": {
          "type": "text",
          "index": "true"
        }
      }
    }
  EOF
  force_destroy                  = true
  depends_on                     = [aws_opensearchserverless_collection.bedrock]
}


# Access Policies

resource "aws_opensearchserverless_security_policy" "encryption" {
  name = "bedrock"
  type = "encryption"
  policy = jsonencode({
    "Rules" = [
      {
        "Resource" = [
          "collection/bedrock"
        ],
        "ResourceType" = "collection"
      }
    ],
    "AWSOwnedKey" = true
  })
}


resource "aws_opensearchserverless_access_policy" "bedrock" {
  name        = "bedrock"
  type        = "data"
  description = "read and write permissions"
  policy      = "[{ \"Rules\": [{ \"Permission\": [\"aoss:CreateIndex\", \"aoss:DeleteIndex\", \"aoss:DescribeIndex\", \"aoss:ReadDocument\", \"aoss:UpdateIndex\", \"aoss:WriteDocument\"], \"Resource\": [\"index/bedrock/*\"], \"ResourceType\": \"index\" }, { \"Permission\": [\"aoss:CreateCollectionItems\", \"aoss:DescribeCollectionItems\", \"aoss:UpdateCollectionItems\"], \"Resource\": [\"collection/bedrock\"], \"ResourceType\": \"collection\" }], \"Principal\": [\"${aws_iam_role.bedrock.arn}\", \"${data.aws_caller_identity.current.arn}\"] }]"
}

resource "aws_opensearchserverless_security_policy" "network" {
  name = "bedrock"
  type = "network"
  policy = jsonencode([
    {
      Rules = [
        {
          ResourceType = "collection"
          Resource = [
            "collection/bedrock"
          ]
        },
        {
          ResourceType = "dashboard"
          Resource = [
            "collection/bedrock"
          ]
        }
      ]
      AllowFromPublic = true
    }
  ])
}


# Wait for permissions to be propagated
resource "time_sleep" "sleep" {
  create_duration = "30s"
  depends_on      = [aws_iam_role_policy.bedrock]
}
