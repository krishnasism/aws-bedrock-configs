resource "aws_iam_role" "bedrock" {
  assume_role_policy = data.aws_iam_policy_document.bedrock_trust.json
  name_prefix        = "AmazonBedrockExecutionRoleForAgents_"
}

resource "aws_iam_role_policy" "bedrock" {
  policy = data.aws_iam_policy_document.bedrock_permissions.json
  role   = aws_iam_role.bedrock.id
}

resource "aws_bedrockagent_agent" "bedrock" {
  agent_name                  = "bedrock"
  agent_resource_role_arn     = aws_iam_role.bedrock.arn
  idle_session_ttl_in_seconds = 500
  foundation_model            = data.aws_bedrock_foundation_model.inference.model_id
}
