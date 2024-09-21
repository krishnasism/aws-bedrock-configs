locals {
  s3_bucket_name = "bedrockdatasource-${data.aws_caller_identity.current.account_id}"
}