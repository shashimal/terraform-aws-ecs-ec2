resource "aws_launch_configuration" "public_ecs_ec2_launch_config" {
  image_id             = "ami-0ac7415dd546fb485"
  iam_instance_profile = aws_iam_instance_profile.ecs_ec2_instance_profile.name
  security_groups      = [aws_security_group.webapp_security_group.id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config"
  instance_type        = "t2.micro"
}

resource "aws_autoscaling_group" "public_ecs_ec2_asg" {
  name                      = "public-ecs-ec2-asg"
  vpc_zone_identifier       = var.public_subnets
  launch_configuration      = aws_launch_configuration.public_ecs_ec2_launch_config.name

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "EC2"
}
