resource "aws_lb_target_group" "web" {

  name = "${var.project_name}-tg"

  port = 80

  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {

    enabled = true

    interval = 30

    path = "/"

    protocol = "HTTP"

    matcher = "200"

    timeout = 5

    healthy_threshold = 3

    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-tg"
  }
}