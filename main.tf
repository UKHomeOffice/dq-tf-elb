resource "aws_alb" "app" {
  subnets            = ["${var.subnet_list}"]
  security_groups    = ["${var.security_groups}"]
  load_balancer_type = "network"
  internal           = true
}

resource "aws_alb_listener" "TCP" {
  load_balancer_arn = "${aws_alb.app.id}"
  port              = "${element(var.TCPPorts, count.index)}"
  protocol          = "TCP"
  count             = "${length(var.TCPPorts)}"

  default_action {
    target_group_arn = "${aws_alb_target_group.app.*.id}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "app" {
  port     = "${element(var.TCPPorts, count.index)}"
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
  count    = "${length(var.TCPPorts)}"
}

resource "aws_autoscaling_group" "app" {
  vpc_zone_identifier  = ["${var.subnet_list}"]
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  launch_configuration = "${var.launch_config}"
  target_group_arns    = ["${aws_alb_target_group.app.*.arn}"]
}
