variable "subnet_list" {
  type        = "list"
  description = "List of subnets used by the Auto Scaling Group"
}

variable "asg_min" {
  default     = 1
  description = "Min instance count within the auto scaling group"
}

variable "asg_max" {
  default     = 2
  description = "Max instance count within the auto scaling group"
}

variable "security_groups" {
  type        = "list"
  description = "List of SG for the launch config resource"
}

variable "vpc_id" {
  description = "Main VPCs identifier"
}

variable "target_group_port" {
  default     = 443
  description = "Target grop port number"
}

variable "protocol_type" {
  default     = "HTTPS"
  description = "Type of network protocol used"
}

variable "instance_profile" {
  description = "Instance profile mapping for the launch configuration"
}

variable "launch_config" {
  description = "Launch config resource ID"
}

variable "lb_type" {
  description = "Switch between network and application"
}
