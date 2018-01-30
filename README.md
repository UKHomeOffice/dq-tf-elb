# dq-tf-elb

This module describe a few resources needed to setup a network load balancer and and an auto-scaling group.
The module only support TCP ports and accept a ports as a simple list eg. ["135","443"]
Depending on port count the appropriate listeners and target groups will get created.

## Input items

| Variable      | Default set   | Usage |
| ------------- |:-------------:| -----:|
|subnet_list | no | add a single list |
|asg_min | yes | support count |
|asg_max | yes | support count |
|security_groups | no | add a single list |
|vpc_id | no | add vpc id |
|launch_config | no | add launch configuration id |
|TCPPorts | no | add single list |
