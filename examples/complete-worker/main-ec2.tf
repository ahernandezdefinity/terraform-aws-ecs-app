module "web_complete" {
  source = "../.."

  name             = "app"
  app_type         = "worker"
  env              = var.env
  namespace        = var.namespace
  ecs_cluster_name = local.ecs_cluster_name

  public               = false
  min_size             = 1
  max_size             = 1
  desired_capacity     = 0
  memory               = 8192
  cpu                  = 1024
  instance_type        = "t3.nano"
  ecs_launch_type      = "EC2"
  ec2_service_group    = "app"
  ecs_network_mode     = "bridge"
  iam_instance_profile = local.iam_instance_profile
  key_name             = local.key_name

  # Containers
  docker_registry  = local.docker_registry
  image_id         = local.image_id
  docker_image_tag = local.docker_image_tag

  docker_container_command           = ["rake", "notify:daily"]
  cloudwatch_schedule_expressions    = ["cron(0 * * * ? *)"]
  deployment_minimum_healthy_percent = 0

  # Network
  vpc_id           = local.vpc_id
  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  security_groups  = local.security_groups
  root_domain_name = var.root_domain_name
  zone_id          = local.zone_id

  # Environment variables
  app_secrets = [
  ]
  environment = {
    ENV      = var.env
    APP_NAME = "App"
  }

  iam_role_policy_statement = [
    {
      Effect   = "Allow",
      Action   = "s3:*",
      Resource = "*"
  }]
}

