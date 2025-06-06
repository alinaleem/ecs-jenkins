output "private_subnets" {
  value = aws_subnet.private[*].id
}