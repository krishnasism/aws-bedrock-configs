resource "aws_opensearchserverless_security_policy" "bedrock" {
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

resource "aws_opensearchserverless_collection" "bedrock" {
  name       = "bedrock"
  depends_on = [aws_opensearchserverless_security_policy.bedrock]
}