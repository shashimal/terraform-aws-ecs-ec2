locals {
  launch_type = "EC2"
}
resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = var.tags
}

resource "aws_ecs_task_definition" "task_definition" {
  for_each = var.service_map

  family                   = each.key
  requires_compatibilities = [local.launch_type]
  network_mode             = "awsvpc"

  container_definitions = jsonencode([
    {
      name      = each.value.name
      image     = each.value.image
      cpu       = each.value.cpu
      memory    = each.value.memory
      essential = each.value.essential

      portMappings = [
        {
          containerPort = each.value.containerPort
          hostPort      = each.value.hostPort
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = "${lower(each.value.name)}-logs"
          awslogs-stream-prefix = lower(each.value.name)
          awslogs-region        = data.aws_region.current.name
        }
      }
    }
  ])
}

resource "aws_ecs_service" "service" {
  for_each = var.service_map

  name = "${each.value.name}-service"
  cluster = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_definition[each.key].arn
  launch_type = local.launch_type
  desired_count = 1

  network_configuration {
    subnets = each.value.is_public ? var.public_subnets : var.private_subnets
    security_groups = each.value.is_public ? [aws_security_group.webapp_security_group.id] : [aws_security_group.webapp_security_group.id]
  }
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  for_each = var.service_map
  name = "${each.key}-logs"
}
