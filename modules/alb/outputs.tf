output "alb_dns" {
  value = aws_lb.main.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "lb_listener" {
  value = aws_lb_listener.http
}
