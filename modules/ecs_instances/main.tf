data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}


resource "aws_launch_template" "ecs_instance_template" {
  name_prefix   = "ecs-instance-"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  key_name      = var.key_name
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo "ECS_CLUSTER=${var.cluster_name}" > /etc/ecs/ecs.config
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo yum install -y unzip curl
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws
EOF
  )

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = element(var.subnet_ids, 0)
    security_groups             = var.security_group_ids
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }
}


resource "aws_autoscaling_group" "ecs_instances_asg" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.ecs_instance_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
