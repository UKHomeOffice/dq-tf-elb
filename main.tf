resource "aws_autoscaling_group" "app" {
  vpc_zone_identifier  = ["${var.subnet_list}"]
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  launch_configuration = "${aws_launch_configuration.app.id}"
  target_group_arns    = ["${aws_alb_target_group.app.arn}"]
}

resource "aws_launch_configuration" "app" {
  security_groups = [
    "${var.security_groups}",
  ]

  key_name                    = "${var.key_name}"
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.instance_profile}"
  user_data                   = "${var.user_data}"
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_target_group" "app" {
  port     = "${var.target_group_port}"
  protocol = "${var.protocol_type}"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb" "app" {
  subnets         = ["${var.subnet_list}"]
  security_groups = ["${var.security_groups}"]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.app.id}"
  port              = "${var.target_group_port}"
  protocol          = "${var.protocol_type}"

  default_action {
    target_group_arn = "${aws_alb_target_group.app.id}"
    type             = "forward"
  }
}
