resource "aws_iam_role" "ecs_ec2_role" {
  name                = "ecs-ec2-role"
  assume_role_policy  = data.aws_iam_policy_document.ecs_assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
}

resource "aws_iam_instance_profile" "ecs_ec2_instance_profile" {
  name = "ecs-ec2-instance-profile"
  role = aws_iam_role.ecs_ec2_role.name
}
