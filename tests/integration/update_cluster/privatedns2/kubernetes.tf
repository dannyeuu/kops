locals {
  bastion_autoscaling_group_ids     = [aws_autoscaling_group.bastion-privatedns2-example-com.id]
  bastion_security_group_ids        = [aws_security_group.bastion-privatedns2-example-com.id]
  bastions_role_arn                 = aws_iam_role.bastions-privatedns2-example-com.arn
  bastions_role_name                = aws_iam_role.bastions-privatedns2-example-com.name
  cluster_name                      = "privatedns2.example.com"
  master_autoscaling_group_ids      = [aws_autoscaling_group.master-us-test-1a-masters-privatedns2-example-com.id]
  master_security_group_ids         = [aws_security_group.masters-privatedns2-example-com.id]
  masters_role_arn                  = aws_iam_role.masters-privatedns2-example-com.arn
  masters_role_name                 = aws_iam_role.masters-privatedns2-example-com.name
  node_autoscaling_group_ids        = [aws_autoscaling_group.nodes-privatedns2-example-com.id]
  node_security_group_ids           = [aws_security_group.nodes-privatedns2-example-com.id]
  node_subnet_ids                   = [aws_subnet.us-test-1a-privatedns2-example-com.id]
  nodes_role_arn                    = aws_iam_role.nodes-privatedns2-example-com.arn
  nodes_role_name                   = aws_iam_role.nodes-privatedns2-example-com.name
  region                            = "us-test-1"
  route_table_private-us-test-1a_id = aws_route_table.private-us-test-1a-privatedns2-example-com.id
  route_table_public_id             = aws_route_table.privatedns2-example-com.id
  subnet_us-test-1a_id              = aws_subnet.us-test-1a-privatedns2-example-com.id
  subnet_utility-us-test-1a_id      = aws_subnet.utility-us-test-1a-privatedns2-example-com.id
  vpc_cidr_block                    = data.aws_vpc.privatedns2-example-com.cidr_block
  vpc_id                            = "vpc-12345678"
  vpc_ipv6_cidr_block               = data.aws_vpc.privatedns2-example-com.ipv6_cidr_block
  vpc_ipv6_cidr_length              = local.vpc_ipv6_cidr_block == "" ? null : tonumber(regex(".*/(\\d+)", local.vpc_ipv6_cidr_block)[0])
}

output "bastion_autoscaling_group_ids" {
  value = [aws_autoscaling_group.bastion-privatedns2-example-com.id]
}

output "bastion_security_group_ids" {
  value = [aws_security_group.bastion-privatedns2-example-com.id]
}

output "bastions_role_arn" {
  value = aws_iam_role.bastions-privatedns2-example-com.arn
}

output "bastions_role_name" {
  value = aws_iam_role.bastions-privatedns2-example-com.name
}

output "cluster_name" {
  value = "privatedns2.example.com"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-us-test-1a-masters-privatedns2-example-com.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-privatedns2-example-com.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-privatedns2-example-com.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-privatedns2-example-com.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-privatedns2-example-com.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-privatedns2-example-com.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.us-test-1a-privatedns2-example-com.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-privatedns2-example-com.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-privatedns2-example-com.name
}

output "region" {
  value = "us-test-1"
}

output "route_table_private-us-test-1a_id" {
  value = aws_route_table.private-us-test-1a-privatedns2-example-com.id
}

output "route_table_public_id" {
  value = aws_route_table.privatedns2-example-com.id
}

output "subnet_us-test-1a_id" {
  value = aws_subnet.us-test-1a-privatedns2-example-com.id
}

output "subnet_utility-us-test-1a_id" {
  value = aws_subnet.utility-us-test-1a-privatedns2-example-com.id
}

output "vpc_cidr_block" {
  value = data.aws_vpc.privatedns2-example-com.cidr_block
}

output "vpc_id" {
  value = "vpc-12345678"
}

output "vpc_ipv6_cidr_block" {
  value = data.aws_vpc.privatedns2-example-com.ipv6_cidr_block
}

output "vpc_ipv6_cidr_length" {
  value = local.vpc_ipv6_cidr_block == "" ? null : tonumber(regex(".*/(\\d+)", local.vpc_ipv6_cidr_block)[0])
}

provider "aws" {
  region = "us-test-1"
}

provider "aws" {
  alias  = "files"
  region = "us-test-1"
}

resource "aws_autoscaling_group" "bastion-privatedns2-example-com" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.bastion-privatedns2-example-com.id
    version = aws_launch_template.bastion-privatedns2-example-com.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "bastion.privatedns2.example.com"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "privatedns2.example.com"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "bastion.privatedns2.example.com"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/bastion"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "bastion"
  }
  tag {
    key                 = "kubernetes.io/cluster/privatedns2.example.com"
    propagate_at_launch = true
    value               = "owned"
  }
  target_group_arns   = [aws_lb_target_group.bastion-privatedns2-examp-e704o2.id]
  vpc_zone_identifier = [aws_subnet.utility-us-test-1a-privatedns2-example-com.id]
}

resource "aws_autoscaling_group" "master-us-test-1a-masters-privatedns2-example-com" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.master-us-test-1a-masters-privatedns2-example-com.id
    version = aws_launch_template.master-us-test-1a-masters-privatedns2-example-com.latest_version
  }
  load_balancers        = [aws_elb.api-privatedns2-example-com.id]
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "master-us-test-1a.masters.privatedns2.example.com"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "privatedns2.example.com"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "master-us-test-1a.masters.privatedns2.example.com"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/control-plane"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "k8s.io/role/master"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-us-test-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/privatedns2.example.com"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-test-1a-privatedns2-example-com.id]
}

resource "aws_autoscaling_group" "nodes-privatedns2-example-com" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-privatedns2-example-com.id
    version = aws_launch_template.nodes-privatedns2-example-com.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 2
  metrics_granularity   = "1Minute"
  min_size              = 2
  name                  = "nodes.privatedns2.example.com"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "privatedns2.example.com"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes.privatedns2.example.com"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes"
  }
  tag {
    key                 = "kubernetes.io/cluster/privatedns2.example.com"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-test-1a-privatedns2-example-com.id]
}

resource "aws_autoscaling_lifecycle_hook" "bastion-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.bastion-privatedns2-example-com.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "bastion-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "master-us-test-1a-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.master-us-test-1a-masters-privatedns2-example-com.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "master-us-test-1a-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "nodes-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.nodes-privatedns2-example-com.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "nodes-NTHLifecycleHook"
}

resource "aws_cloudwatch_event_rule" "privatedns2-example-com-ASGLifecycle" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_privatedns2.example.com-ASGLifecycle_event_pattern")
  name          = "privatedns2.example.com-ASGLifecycle"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "privatedns2.example.com-ASGLifecycle"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "privatedns2-example-com-InstanceScheduledChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_privatedns2.example.com-InstanceScheduledChange_event_pattern")
  name          = "privatedns2.example.com-InstanceScheduledChange"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "privatedns2.example.com-InstanceScheduledChange"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "privatedns2-example-com-InstanceStateChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_privatedns2.example.com-InstanceStateChange_event_pattern")
  name          = "privatedns2.example.com-InstanceStateChange"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "privatedns2.example.com-InstanceStateChange"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "privatedns2-example-com-SpotInterruption" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_privatedns2.example.com-SpotInterruption_event_pattern")
  name          = "privatedns2.example.com-SpotInterruption"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "privatedns2.example.com-SpotInterruption"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_cloudwatch_event_target" "privatedns2-example-com-ASGLifecycle-Target" {
  arn  = aws_sqs_queue.privatedns2-example-com-nth.arn
  rule = aws_cloudwatch_event_rule.privatedns2-example-com-ASGLifecycle.id
}

resource "aws_cloudwatch_event_target" "privatedns2-example-com-InstanceScheduledChange-Target" {
  arn  = aws_sqs_queue.privatedns2-example-com-nth.arn
  rule = aws_cloudwatch_event_rule.privatedns2-example-com-InstanceScheduledChange.id
}

resource "aws_cloudwatch_event_target" "privatedns2-example-com-InstanceStateChange-Target" {
  arn  = aws_sqs_queue.privatedns2-example-com-nth.arn
  rule = aws_cloudwatch_event_rule.privatedns2-example-com-InstanceStateChange.id
}

resource "aws_cloudwatch_event_target" "privatedns2-example-com-SpotInterruption-Target" {
  arn  = aws_sqs_queue.privatedns2-example-com-nth.arn
  rule = aws_cloudwatch_event_rule.privatedns2-example-com-SpotInterruption.id
}

resource "aws_ebs_volume" "us-test-1a-etcd-events-privatedns2-example-com" {
  availability_zone = "us-test-1a"
  encrypted         = false
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "us-test-1a.etcd-events.privatedns2.example.com"
    "k8s.io/etcd/events"                            = "us-test-1a/us-test-1a"
    "k8s.io/role/control-plane"                     = "1"
    "k8s.io/role/master"                            = "1"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_ebs_volume" "us-test-1a-etcd-main-privatedns2-example-com" {
  availability_zone = "us-test-1a"
  encrypted         = false
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "us-test-1a.etcd-main.privatedns2.example.com"
    "k8s.io/etcd/main"                              = "us-test-1a/us-test-1a"
    "k8s.io/role/control-plane"                     = "1"
    "k8s.io/role/master"                            = "1"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_eip" "us-test-1a-privatedns2-example-com" {
  domain = "vpc"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "us-test-1a.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_elb" "api-privatedns2-example-com" {
  connection_draining         = true
  connection_draining_timeout = 300
  cross_zone_load_balancing   = false
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "SSL:443"
    timeout             = 5
    unhealthy_threshold = 2
  }
  idle_timeout = 300
  listener {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }
  name            = "api-privatedns2-example-c-6jft30"
  security_groups = [aws_security_group.api-elb-privatedns2-example-com.id]
  subnets         = [aws_subnet.utility-us-test-1a-privatedns2-example-com.id]
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "api.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "bastions-privatedns2-example-com" {
  name = "bastions.privatedns2.example.com"
  role = aws_iam_role.bastions-privatedns2-example-com.name
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "bastions.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-privatedns2-example-com" {
  name = "masters.privatedns2.example.com"
  role = aws_iam_role.masters-privatedns2-example-com.name
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "masters.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "nodes-privatedns2-example-com" {
  name = "nodes.privatedns2.example.com"
  role = aws_iam_role.nodes-privatedns2-example-com.name
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "nodes.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_iam_role" "bastions-privatedns2-example-com" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_bastions.privatedns2.example.com_policy")
  name               = "bastions.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "bastions.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_iam_role" "masters-privatedns2-example-com" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.privatedns2.example.com_policy")
  name               = "masters.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "masters.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_iam_role" "nodes-privatedns2-example-com" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.privatedns2.example.com_policy")
  name               = "nodes.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "nodes.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_iam_role_policy" "bastions-privatedns2-example-com" {
  name   = "bastions.privatedns2.example.com"
  policy = file("${path.module}/data/aws_iam_role_policy_bastions.privatedns2.example.com_policy")
  role   = aws_iam_role.bastions-privatedns2-example-com.name
}

resource "aws_iam_role_policy" "masters-privatedns2-example-com" {
  name   = "masters.privatedns2.example.com"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.privatedns2.example.com_policy")
  role   = aws_iam_role.masters-privatedns2-example-com.name
}

resource "aws_iam_role_policy" "nodes-privatedns2-example-com" {
  name   = "nodes.privatedns2.example.com"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.privatedns2.example.com_policy")
  role   = aws_iam_role.nodes-privatedns2-example-com.name
}

resource "aws_key_pair" "kubernetes-privatedns2-example-com-c4a6ed9aa889b9e2c39cd663eb9c7157" {
  key_name   = "kubernetes.privatedns2.example.com-c4:a6:ed:9a:a8:89:b9:e2:c3:9c:d6:63:eb:9c:71:57"
  public_key = file("${path.module}/data/aws_key_pair_kubernetes.privatedns2.example.com-c4a6ed9aa889b9e2c39cd663eb9c7157_public_key")
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_launch_template" "bastion-privatedns2-example-com" {
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 32
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.bastions-privatedns2-example-com.id
  }
  image_id      = "ami-12345678"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.kubernetes-privatedns2-example-com-c4a6ed9aa889b9e2c39cd663eb9c7157.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
  }
  monitoring {
    enabled = false
  }
  name = "bastion.privatedns2.example.com"
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.bastion-privatedns2-example-com.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                             = "privatedns2.example.com"
      "Name"                                          = "bastion.privatedns2.example.com"
      "aws-node-termination-handler/managed"          = ""
      "k8s.io/role/bastion"                           = "1"
      "kops.k8s.io/instancegroup"                     = "bastion"
      "kubernetes.io/cluster/privatedns2.example.com" = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                             = "privatedns2.example.com"
      "Name"                                          = "bastion.privatedns2.example.com"
      "aws-node-termination-handler/managed"          = ""
      "k8s.io/role/bastion"                           = "1"
      "kops.k8s.io/instancegroup"                     = "bastion"
      "kubernetes.io/cluster/privatedns2.example.com" = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "bastion.privatedns2.example.com"
    "aws-node-termination-handler/managed"          = ""
    "k8s.io/role/bastion"                           = "1"
    "kops.k8s.io/instancegroup"                     = "bastion"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_launch_template" "master-us-test-1a-masters-privatedns2-example-com" {
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 64
      volume_type           = "gp3"
    }
  }
  block_device_mappings {
    device_name  = "/dev/sdc"
    virtual_name = "ephemeral0"
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.masters-privatedns2-example-com.id
  }
  image_id      = "ami-12345678"
  instance_type = "m3.medium"
  key_name      = aws_key_pair.kubernetes-privatedns2-example-com-c4a6ed9aa889b9e2c39cd663eb9c7157.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
  }
  monitoring {
    enabled = false
  }
  name = "master-us-test-1a.masters.privatedns2.example.com"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.masters-privatedns2-example-com.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                                                     = "privatedns2.example.com"
      "Name"                                                                                                  = "master-us-test-1a.masters.privatedns2.example.com"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-us-test-1a"
      "kubernetes.io/cluster/privatedns2.example.com"                                                         = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                                                     = "privatedns2.example.com"
      "Name"                                                                                                  = "master-us-test-1a.masters.privatedns2.example.com"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-us-test-1a"
      "kubernetes.io/cluster/privatedns2.example.com"                                                         = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                                                     = "privatedns2.example.com"
    "Name"                                                                                                  = "master-us-test-1a.masters.privatedns2.example.com"
    "aws-node-termination-handler/managed"                                                                  = ""
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
    "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
    "k8s.io/role/control-plane"                                                                             = "1"
    "k8s.io/role/master"                                                                                    = "1"
    "kops.k8s.io/instancegroup"                                                                             = "master-us-test-1a"
    "kubernetes.io/cluster/privatedns2.example.com"                                                         = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_master-us-test-1a.masters.privatedns2.example.com_user_data")
}

resource "aws_launch_template" "nodes-privatedns2-example-com" {
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 128
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-privatedns2-example-com.id
  }
  image_id      = "ami-12345678"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.kubernetes-privatedns2-example-com-c4a6ed9aa889b9e2c39cd663eb9c7157.id
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
  }
  monitoring {
    enabled = false
  }
  name = "nodes.privatedns2.example.com"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-privatedns2-example-com.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "privatedns2.example.com"
      "Name"                                                                       = "nodes.privatedns2.example.com"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes"
      "kubernetes.io/cluster/privatedns2.example.com"                              = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "privatedns2.example.com"
      "Name"                                                                       = "nodes.privatedns2.example.com"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes"
      "kubernetes.io/cluster/privatedns2.example.com"                              = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "privatedns2.example.com"
    "Name"                                                                       = "nodes.privatedns2.example.com"
    "aws-node-termination-handler/managed"                                       = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes"
    "kubernetes.io/cluster/privatedns2.example.com"                              = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes.privatedns2.example.com_user_data")
}

resource "aws_lb" "bastion-privatedns2-example-com" {
  enable_cross_zone_load_balancing = false
  internal                         = false
  load_balancer_type               = "network"
  name                             = "bastion-privatedns2-examp-e704o2"
  security_groups                  = [aws_security_group.bastion-elb-privatedns2-example-com.id]
  subnet_mapping {
    subnet_id = aws_subnet.utility-us-test-1a-privatedns2-example-com.id
  }
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "bastion.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_lb_listener" "bastion-privatedns2-example-com-22" {
  default_action {
    target_group_arn = aws_lb_target_group.bastion-privatedns2-examp-e704o2.id
    type             = "forward"
  }
  load_balancer_arn = aws_lb.bastion-privatedns2-example-com.id
  port              = 22
  protocol          = "TCP"
}

resource "aws_lb_target_group" "bastion-privatedns2-examp-e704o2" {
  connection_termination = "true"
  deregistration_delay   = "30"
  health_check {
    healthy_threshold   = 2
    interval            = 10
    protocol            = "TCP"
    unhealthy_threshold = 2
  }
  name     = "bastion-privatedns2-examp-e704o2"
  port     = 22
  protocol = "TCP"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "bastion-privatedns2-examp-e704o2"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_nat_gateway" "us-test-1a-privatedns2-example-com" {
  allocation_id = aws_eip.us-test-1a-privatedns2-example-com.id
  subnet_id     = aws_subnet.utility-us-test-1a-privatedns2-example-com.id
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "us-test-1a.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-1"
  route_table_id         = aws_route_table.privatedns2-example-com.id
}

resource "aws_route" "route-__--0" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = "igw-1"
  route_table_id              = aws_route_table.privatedns2-example-com.id
}

resource "aws_route" "route-private-us-test-1a-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.us-test-1a-privatedns2-example-com.id
  route_table_id         = aws_route_table.private-us-test-1a-privatedns2-example-com.id
}

resource "aws_route53_record" "api-privatedns2-example-com" {
  alias {
    evaluate_target_health = false
    name                   = aws_elb.api-privatedns2-example-com.dns_name
    zone_id                = aws_elb.api-privatedns2-example-com.zone_id
  }
  name    = "api.privatedns2.example.com"
  type    = "A"
  zone_id = "/hostedzone/Z3AFAKE1ZOMORE"
}

resource "aws_route53_record" "api-privatedns2-example-com-AAAA" {
  alias {
    evaluate_target_health = false
    name                   = aws_elb.api-privatedns2-example-com.dns_name
    zone_id                = aws_elb.api-privatedns2-example-com.zone_id
  }
  name    = "api.privatedns2.example.com"
  type    = "AAAA"
  zone_id = "/hostedzone/Z3AFAKE1ZOMORE"
}

resource "aws_route_table" "private-us-test-1a-privatedns2-example-com" {
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "private-us-test-1a.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
    "kubernetes.io/kops/role"                       = "private-us-test-1a"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_route_table" "privatedns2-example-com" {
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
    "kubernetes.io/kops/role"                       = "public"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_route_table_association" "private-us-test-1a-privatedns2-example-com" {
  route_table_id = aws_route_table.private-us-test-1a-privatedns2-example-com.id
  subnet_id      = aws_subnet.us-test-1a-privatedns2-example-com.id
}

resource "aws_route_table_association" "utility-us-test-1a-privatedns2-example-com" {
  route_table_id = aws_route_table.privatedns2-example-com.id
  subnet_id      = aws_subnet.utility-us-test-1a-privatedns2-example-com.id
}

resource "aws_s3_object" "cluster-completed-spec" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_cluster-completed.spec_content")
  key                    = "clusters.example.com/privatedns2.example.com/cluster-completed.spec"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "etcd-cluster-spec-events" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-events_content")
  key                    = "clusters.example.com/privatedns2.example.com/backups/etcd/events/control/etcd-cluster-spec"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "etcd-cluster-spec-main" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-main_content")
  key                    = "clusters.example.com/privatedns2.example.com/backups/etcd/main/control/etcd-cluster-spec"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "kops-version-txt" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_kops-version.txt_content")
  key                    = "clusters.example.com/privatedns2.example.com/kops-version.txt"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "manifests-etcdmanager-events-master-us-test-1a" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-events-master-us-test-1a_content")
  key                    = "clusters.example.com/privatedns2.example.com/manifests/etcd/events-master-us-test-1a.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "manifests-etcdmanager-main-master-us-test-1a" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-main-master-us-test-1a_content")
  key                    = "clusters.example.com/privatedns2.example.com/manifests/etcd/main-master-us-test-1a.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "manifests-static-kube-apiserver-healthcheck" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_manifests-static-kube-apiserver-healthcheck_content")
  key                    = "clusters.example.com/privatedns2.example.com/manifests/static/kube-apiserver-healthcheck.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "nodeupconfig-master-us-test-1a" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_nodeupconfig-master-us-test-1a_content")
  key                    = "clusters.example.com/privatedns2.example.com/igconfig/control-plane/master-us-test-1a/nodeupconfig.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "nodeupconfig-nodes" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes_content")
  key                    = "clusters.example.com/privatedns2.example.com/igconfig/node/nodes/nodeupconfig.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-aws-cloud-controller-addons-k8s-io-k8s-1-18" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-aws-cloud-controller.addons.k8s.io-k8s-1.18_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/aws-cloud-controller.addons.k8s.io/k8s-1.18.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-aws-ebs-csi-driver-addons-k8s-io-k8s-1-17" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-aws-ebs-csi-driver.addons.k8s.io-k8s-1.17_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/aws-ebs-csi-driver.addons.k8s.io/k8s-1.17.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-bootstrap" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-bootstrap_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/bootstrap-channel.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-coredns-addons-k8s-io-k8s-1-12" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-coredns.addons.k8s.io-k8s-1.12_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/coredns.addons.k8s.io/k8s-1.12.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-dns-controller-addons-k8s-io-k8s-1-12" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-dns-controller.addons.k8s.io-k8s-1.12_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/dns-controller.addons.k8s.io/k8s-1.12.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-kops-controller-addons-k8s-io-k8s-1-16" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-kops-controller.addons.k8s.io-k8s-1.16_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/kops-controller.addons.k8s.io/k8s-1.16.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-kubelet-api-rbac-addons-k8s-io-k8s-1-9" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-limit-range-addons-k8s-io" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-limit-range.addons.k8s.io_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/limit-range.addons.k8s.io/v1.5.0.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-node-termination-handler-aws-k8s-1-11" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-node-termination-handler.aws-k8s-1.11_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/node-termination-handler.aws/k8s-1.11.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "privatedns2-example-com-addons-storage-aws-addons-k8s-io-v1-15-0" {
  bucket                 = "testingBucket"
  content                = file("${path.module}/data/aws_s3_object_privatedns2.example.com-addons-storage-aws.addons.k8s.io-v1.15.0_content")
  key                    = "clusters.example.com/privatedns2.example.com/addons/storage-aws.addons.k8s.io/v1.15.0.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_security_group" "api-elb-privatedns2-example-com" {
  description = "Security group for api ELB"
  name        = "api-elb.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "api-elb.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_security_group" "bastion-elb-privatedns2-example-com" {
  description = "Security group for bastion ELB"
  name        = "bastion-elb.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "bastion-elb.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_security_group" "bastion-privatedns2-example-com" {
  description = "Security group for bastion"
  name        = "bastion.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "bastion.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_security_group" "masters-privatedns2-example-com" {
  description = "Security group for masters"
  name        = "masters.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "masters.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_security_group" "nodes-privatedns2-example-com" {
  description = "Security group for nodes"
  name        = "nodes.privatedns2.example.com"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "nodes.privatedns2.example.com"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-bastion-elb-privatedns2-example-com" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-443to443-api-elb-privatedns2-example-com" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.api-elb-privatedns2-example-com.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-172-20-4-0--22-ingress-tcp-22to22-bastion-elb-privatedns2-example-com" {
  cidr_blocks       = ["172.20.4.0/22"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-api-elb-privatedns2-example-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-api-elb-privatedns2-example-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-privatedns2-example-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-privatedns2-example-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-privatedns2-example-com-ingress-icmp-3to4-bastion-privatedns2-example-com" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.bastion-privatedns2-example-com.id
  source_security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-elb-privatedns2-example-com-ingress-tcp-22to22-bastion-privatedns2-example-com" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion-privatedns2-example-com.id
  source_security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-privatedns2-example-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-privatedns2-example-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-privatedns2-example-com-ingress-icmp-3to4-bastion-elb-privatedns2-example-com" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.bastion-elb-privatedns2-example-com.id
  source_security_group_id = aws_security_group.bastion-privatedns2-example-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-privatedns2-example-com-ingress-tcp-22to22-masters-privatedns2-example-com" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.bastion-privatedns2-example-com.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-privatedns2-example-com-ingress-tcp-22to22-nodes-privatedns2-example-com" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nodes-privatedns2-example-com.id
  source_security_group_id = aws_security_group.bastion-privatedns2-example-com.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-privatedns2-example-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-privatedns2-example-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.masters-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-privatedns2-example-com-ingress-all-0to0-masters-privatedns2-example-com" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.masters-privatedns2-example-com.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-privatedns2-example-com-ingress-all-0to0-nodes-privatedns2-example-com" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-privatedns2-example-com.id
  source_security_group_id = aws_security_group.masters-privatedns2-example-com.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-privatedns2-example-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-privatedns2-example-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-privatedns2-example-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-privatedns2-example-com-ingress-all-0to0-nodes-privatedns2-example-com" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-privatedns2-example-com.id
  source_security_group_id = aws_security_group.nodes-privatedns2-example-com.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-privatedns2-example-com-ingress-tcp-1to2379-masters-privatedns2-example-com" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.nodes-privatedns2-example-com.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-privatedns2-example-com-ingress-tcp-2382to4000-masters-privatedns2-example-com" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.nodes-privatedns2-example-com.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-privatedns2-example-com-ingress-tcp-4003to65535-masters-privatedns2-example-com" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.nodes-privatedns2-example-com.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-privatedns2-example-com-ingress-udp-1to65535-masters-privatedns2-example-com" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.nodes-privatedns2-example-com.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "https-elb-to-master" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.api-elb-privatedns2-example-com.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.api-elb-privatedns2-example-com.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-cp-to-elb" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.api-elb-privatedns2-example-com.id
  source_security_group_id = aws_security_group.masters-privatedns2-example-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-elb-to-cp" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.masters-privatedns2-example-com.id
  source_security_group_id = aws_security_group.api-elb-privatedns2-example-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-ssh-nlb-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-ssh-nlb-172-20-4-0--22" {
  cidr_blocks       = ["172.20.4.0/22"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.bastion-elb-privatedns2-example-com.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_sqs_queue" "privatedns2-example-com-nth" {
  message_retention_seconds = 300
  name                      = "privatedns2-example-com-nth"
  policy                    = file("${path.module}/data/aws_sqs_queue_privatedns2-example-com-nth_policy")
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "privatedns2-example-com-nth"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
  }
}

resource "aws_subnet" "us-test-1a-privatedns2-example-com" {
  availability_zone                           = "us-test-1a"
  cidr_block                                  = "172.20.32.0/19"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "us-test-1a.privatedns2.example.com"
    "SubnetType"                                    = "Private"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
    "kubernetes.io/role/internal-elb"               = "1"
  }
  vpc_id = "vpc-12345678"
}

resource "aws_subnet" "utility-us-test-1a-privatedns2-example-com" {
  availability_zone                           = "us-test-1a"
  cidr_block                                  = "172.20.4.0/22"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                             = "privatedns2.example.com"
    "Name"                                          = "utility-us-test-1a.privatedns2.example.com"
    "SubnetType"                                    = "Utility"
    "kubernetes.io/cluster/privatedns2.example.com" = "owned"
    "kubernetes.io/role/elb"                        = "1"
  }
  vpc_id = "vpc-12345678"
}

data "aws_vpc" "privatedns2-example-com" {
  id = "vpc-12345678"
}

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      "configuration_aliases" = [aws.files]
      "source"                = "hashicorp/aws"
      "version"               = ">= 5.0.0"
    }
  }
}
