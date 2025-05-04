resource "aws_lb" "web_lb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnet_ids
  enable_deletion_protection = false
}

locals {
  target_groups = ["green", "blue"]
  active_index  = index(local.target_groups, var.active_color)
}

resource "aws_lb_target_group" "web_tg" {
  count        = length(local.target_groups)
  name_prefix  = "web${count.index}-"
  port         = 80
  protocol     = "HTTP"
  vpc_id       = var.vpc_id
  target_type  = "instance"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200,301,302,404"
  }

  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_lb_listener" "l_443" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg[0].arn
  }

  depends_on = [aws_lb_target_group.web_tg]

  lifecycle {
    ignore_changes = [default_action]
  }
}

resource "aws_lb_listener" "l_8080" {
  load_balancer_arn = aws_lb.web_lb.id
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg[1].arn
  }
}

