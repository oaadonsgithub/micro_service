output "alb_dns_name" {
  value = aws_lb.web_lb.dns_name
}

output "ecs_service_name" {
  value = aws_ecs_service.frontend.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.web_cluster.name
}
