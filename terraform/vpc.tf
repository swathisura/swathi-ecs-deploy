# ─────────────────────────────────────────
# Use Existing Default VPC
# ─────────────────────────────────────────
data "aws_vpc" "main" {
  default = true
}

# ─────────────────────────────────────────
# Use Existing Default Subnets
# ─────────────────────────────────────────
data "aws_subnet" "public_1" {
  id = "subnet-0cc23dc8400d81bf3"
}

data "aws_subnet" "public_2" {
  id = "subnet-00efaeabe6a244f6f"
}

# ─────────────────────────────────────────
# Security Group for ECS
# ─────────────────────────────────────────
resource "aws_security_group" "ecs_sg" {
  name        = "${var.app_name}-ecs-sg"
  description = "Allow traffic to ECS tasks"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-ecs-sg"
  }
}

# ─────────────────────────────────────────
# Security Group for ALB
# ─────────────────────────────────────────
resource "aws_security_group" "alb_sg" {
  name        = "${var.app_name}-alb-sg"
  description = "Allow traffic to ALB"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-alb-sg"
  }
}