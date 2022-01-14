data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "asg_ecs_ec2_user_data" {
  template = file("${path.module}/ecs_ec2_user_data.sh.tpl")

  vars = {
    ecs_cluster_name  = local.ecs_cluster_name
    env               = var.env
    ec2_service_group = var.ec2_service_group
  }
}
