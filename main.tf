locals {
  apps = {
    ui = {
      ecr_repository_name = "ui"
      app_path            = "ui"
      image_version       = "1.0.0"
      app_name            = "ui"
      port                = 80
      path_pattern        = "/*"
      healthcheck_path    = "/*"
    }
    # api = {
    #   ecr_repository_name = "api"
    #   app_path            = "api"
    #   image_version       = "1.0.0"
    #   app_name            = "api"
    #   port                = 80
    #   path_pattern        = "/api/*"
    #   healthcheck_path    = "/api/healthcheck"
    # }
  }
}
#Root Main.tf
module "infra" {
  source      = "./modules/infra"
  vpc_cidr    = "10.0.0.0/16"
  num_subnets = 3
  allowed_ips = ["0.0.0.0/0"]
}
module "app" {
  for_each              = local.apps
  depends_on            = [local_file.dockerfile]
  source                = "./modules/app"
  ecr_repository_name   = each.value.ecr_repository_name
  app_path              = each.value.app_path
  image_version         = each.value.image_version
  app_name              = each.value.app_name
  port                  = each.value.port
  path_pattern          = each.value.path_pattern
  execution_role_arn    = module.infra.execution_role_arn
  app_security_group_id = module.infra.app_security_group_id
  subnets               = module.infra.public_subnets
  cluster_arn           = module.infra.cluster_arn
  is_public             = true
  vpc_id                = module.infra.vpc_id
  alb_listener_arn      = module.infra.alb_listener_arn
}
resource "local_file" "dockerfile" {
  content  = template("modules/app/apps/templates/ui.tftpl", { build_args = { "backend_url" = module.infra.alb_dns_name } })
  filename = "modules/app/apps/ui/Dockerfile"
}
output "alb_dns_name"{
  value="http://${module.infra.alb_dns_name}"
}