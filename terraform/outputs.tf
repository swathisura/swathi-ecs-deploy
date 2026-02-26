# ─────────────────────────────────────────
# VPC Outputs
# ─────────────────────────────────────────
output "vpc_id" {
  description = "Default VPC ID"
  value       = data.aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "Public Subnet 1 ID"
  value       = data.aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "Public Subnet 2 ID"
  value       = data.aws_subnet.public_2.id
}

# ─────────────────────────────────────────
# ECR Outputs
# ─────────────────────────────────────────
output "ecr_repository_url" {
  description = "ECR Repository URL - Use this in GitHub Secrets"
  value       = aws_ecr_repository.main.repository_url
}

output "ecr_repository_name" {
  description = "ECR Repository Name"
  value       = aws_ecr_repository.main.name
}

# ─────────────────────────────────────────
# ECS Outputs
# ─────────────────────────────────────────
output "ecs_cluster_name" {
  description = "ECS Cluster Name - Use this in GitHub Secrets"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS Service Name - Use this in GitHub Secrets"
  value       = aws_ecs_service.main.name
}

# ─────────────────────────────────────────
# ALB Outputs
# ─────────────────────────────────────────
output "alb_dns_name" {
  description = "ALB DNS Name - Your App URL"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.main.arn
}

# ─────────────────────────────────────────
# CodeDeploy Outputs
# ─────────────────────────────────────────
output "codedeploy_app_name" {
  description = "CodeDeploy App Name - Use this in GitHub Secrets"
  value       = aws_codedeploy_app.main.name
}

output "codedeploy_deployment_group_name" {
  description = "CodeDeploy Deployment Group - Use this in GitHub Secrets"
  value       = aws_codedeploy_deployment_group.main.deployment_group_name
}

# ─────────────────────────────────────────
# IAM Outputs
# ─────────────────────────────────────────
output "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  value       = local.ecs_task_execution_role_arn
}

output "codedeploy_role_arn" {
  description = "CodeDeploy Role ARN"
  value       = local.codedeploy_role_arn
}