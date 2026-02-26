# ─────────────────────────────────────────
# ECS Cluster
# ─────────────────────────────────────────
resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.app_name}-cluster"
  }
}

# ─────────────────────────────────────────
# ECS Task Definition
# ─────────────────────────────────────────
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.app_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = local.ecs_task_execution_role_arn
  task_role_arn            = local.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.app_name}-container"
      image     = "${aws_ecr_repository.main.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = {
    Name = "${var.app_name}-task"
  }
}

# ─────────────────────────────────────────
# ECS Service
# ─────────────────────────────────────────
resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = [data.aws_subnet.public_1.id, data.aws_subnet.public_2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = "${var.app_name}-container"
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]
  }

  depends_on = [
    aws_lb_listener.main
  ]

  tags = {
    Name = "${var.app_name}-service"
  }
}