variable "vector_index" {
  type    = string
  default = "bedrock-knowledge-base-default-index"
}

variable "vector_field" {
  type    = string
  default = "bedrock-knowledge-base-default-vector"
}

# Change this
variable "unique_number" {
  type    = string
  default = "119992223301"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
