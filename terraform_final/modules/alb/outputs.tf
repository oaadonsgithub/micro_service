output "tg_blue" {
  value = aws_lb_target_group.web_tg[0].arn
}

output "tg_green" {
  value = aws_lb_target_group.web_tg[1].arn
}

output "listener_443" {
  value = aws_lb_listener.l_443.arn
}

output "listener_8080" {
  value = aws_lb_listener.l_8080.arn
}