terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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
