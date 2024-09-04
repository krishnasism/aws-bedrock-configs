terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    opensearch = {
      source = "opensearch-project/opensearch"
      version = "2.3.0"
    }
  }
  backend "s3" {
    bucket = "terraformlocksbucket"
    key    = "locks/bedrockconfigs"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

provider "opensearch" {
  url         = aws_opensearchserverless_collection.bedrock.collection_endpoint
  healthcheck = false
}
