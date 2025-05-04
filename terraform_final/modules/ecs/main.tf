resource "aws_ecs_cluster" "web_cluster" {
  name = "application_cluster"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/ecs/frontend"
}

resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "frontend-task"
  requires_compatibilities = ["EC2"]
  memory                   = 1800
  cpu                      = 512
  execution_role_arn       = var.web_task_role_arn

  container_definitions = jsonencode([{
    name      = "web",
    image     = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/web-ecr-repository:latest",
    essential = true,
    portMappings = [{ containerPort = 80 }],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.main.name,
        awslogs-stream-prefix = "ecs",
        awslogs-region        = var.region
      }
    }
  }])
}

resource "aws_ecs_service" "frontend" {
  name                               = "frontend"
  cluster                            = aws_ecs_cluster.web_cluster.id
  task_definition                    = aws_ecs_task_definition.frontend_task.arn
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 300
  launch_type                        = "EC2"
  scheduling_strategy                = "REPLICA"
  desired_count                      = 2
  force_new_deployment               = true

  load_balancer {
    target_group_arn = var.tg_blue
    container_name   = "web"
    container_port   = 80
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count, load_balancer]
  }
}

