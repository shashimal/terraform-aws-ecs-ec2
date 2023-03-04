cluster_name = "ecs-ec2"

service_map = {
  nginx = {
    name          = "nginx"
    image         = "nginx"
    cpu           = 10
    memory        = 512
    containerPort = 80
    hostPort      = 80
    essential     = true
  }
}
