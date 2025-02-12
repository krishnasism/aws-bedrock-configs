output "bedrock_agent_id" {
  value = aws_bedrockagent_agent.bedrock.agent_id
}

output "bedrock_agent_alias_id" {
  value = aws_bedrockagent_agent_alias.bedrock.agent_alias_id
}

output "knowledge_base_id" {
    value = aws_bedrockagent_knowledge_base.bedrock.id
}
