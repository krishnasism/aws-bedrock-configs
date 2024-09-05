variable "vector_index" {
  type    = string
  default = "default-bedrock-agent-index"
}

variable "vector_field" {
  type    = string
  default = "default-bedrock-agent-field-embeddings"
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
