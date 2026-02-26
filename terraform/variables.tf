variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "swathi"
}

variable "container_port" {
  type    = number
  default = 1337
}

variable "task_cpu" {
  type    = string
  default = "1024"
}

variable "task_memory" {
  type    = string
  default = "2048"
}

variable "desired_count" {
  type    = number
  default = 1
}