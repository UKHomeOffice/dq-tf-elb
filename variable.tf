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

variable "launch_config" {
  description = "Launch config resource ID"
}

variable "TCPPorts" {
  type        = "list"
  description = "List of ports as a sinmple list"
}
