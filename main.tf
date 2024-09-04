terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraformlocks"
    key    = "locks/bedrockconfigs"
    region = var.aws_region
  }
}

provider "aws" {
  region = var.aws_region
}
