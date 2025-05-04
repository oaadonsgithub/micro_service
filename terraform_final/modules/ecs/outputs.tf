output "cluster_name" {
  value = aws_ecs_cluster.web_cluster.name
}

output "service_name" {
  value = aws_ecs_service.frontend.name
}
