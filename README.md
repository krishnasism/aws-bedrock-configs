# aws-bedrock-configs
Terraform configuration for AWS Bedrock. Creates resources for AWS Bedrock Agent with Knowledgebase (Opensearch + S3).

## Deploy
- Create an s3 bucket manually called `terraformlocksbucket`
- Make sure that you have [access](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html#:~:text=To%20manage%20model%20access%2C%20sign,before%20requesting%20access%20to%20it.) to the required models in [models.tf](models.tf)
- Change the value of the variable `unique_number` to something random - to make s3 bucket name unique (required by AWS).
- Do terraform stuff
    ```zsh
    terraform init
    terraform plan
    terraform apply
    ```

## Usage
- The configurations will provision a [Bedrock Agent](https://aws.amazon.com/bedrock/agents/) that you can interact with.
- Upload a file to the S3 [bucket](s3.tf)
- Go to Knowledge Base, select the data source, and click on Sync.
- After the Sync is done, you can chat with the Agent

