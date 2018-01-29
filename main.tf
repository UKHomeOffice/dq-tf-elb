resource "aws_alb" "app" {
  subnets            = ["${var.subnet_list}"]
  security_groups    = ["${var.security_groups}"]
  load_balancer_type = "${var.lb_type}"
  internal           = true
}

resource "aws_alb_listener" "app" {
  load_balancer_arn = "${aws_alb.app.id}"
  port              = "${var.target_group_port}"
  protocol          = "${var.protocol_type}"

  default_action {
    target_group_arn = "${aws_alb_target_group.app.id}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "app" {
  port     = "${var.target_group_port}"
  protocol = "${var.protocol_type}"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_autoscaling_group" "app" {
  vpc_zone_identifier  = ["${var.subnet_list}"]
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  launch_configuration = "${var.launch_config}"
  target_group_arns    = ["${aws_alb_target_group.app.arn}"]
}
