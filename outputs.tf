output "ecs_cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

#output "ecs_task_definition" {
#  value = aws_ecs_task_definition.task_definition["httpd"]
#}
