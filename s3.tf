resource "aws_s3_bucket" "source" {
  bucket = local.s3_bucket_name
}
