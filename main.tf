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
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}
