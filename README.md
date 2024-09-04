# aws-bedrock-configs
Terraform configuration for AWS Bedrock. Creates resources for AWS Bedrock Agent with Knowledgebase (Opensearch + S3).

## Usage
- Create an s3 bucket manually called `terraformlocksbucket`
- Make sure that you have [access](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html#:~:text=To%20manage%20model%20access%2C%20sign,before%20requesting%20access%20to%20it.) to the required models in [data.tf](data.tf)
- Do terraform stuff
