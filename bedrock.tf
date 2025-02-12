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
  instruction                 = "You are a legal AI assistant. You must be factual and objective. Do not answer outside knowledgebase. $output_format_instructions$"
}

resource "aws_bedrockagent_agent_alias" "bedrock" {
  agent_alias_name = "bedrock-main"
  agent_id         = aws_bedrockagent_agent.bedrock.agent_id
  description      = "Bedrock main agent alias"
  depends_on = [aws_bedrockagent_agent_knowledge_base_association.bedrock] 
}
