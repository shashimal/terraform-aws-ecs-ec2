resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = var.tags
}

resource "aws_ecs_task_definition" "task_definition" {
  for_each = var.service_map

  family                   = each.key
  requires_compatibilities = ["EC2"]
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
