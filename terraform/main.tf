module "network" {
  source                    = "./modules/network"
  vpc_cidr                  = var.vpc_cidr
  public_subnet_cidr        = var.public_subnet_cidr
  private_app_subnet_cidr   = var.private_app_subnet_cidr
  private_db_subnet_cidr    = var.private_db_subnet_cidr
  client_name               = var.client_name
}


module "security" {
  source      = "./modules/security"
  vpc_id      = module.network.vpc_id
  client_name = var.client_name
}


module "compute" {
  source                 = "./modules/compute"

  public_subnet_id       = module.network.public_subnet_id
  private_app_subnet_id  = module.network.private_app_subnet_id
  private_db_subnet_id   = module.network.private_db_subnet_id

  instance_type          = var.instance_type
  web_sg_id              = module.security.web_sg_id
  app_sg_id              = module.security.app_sg_id
  db_sg_id               = module.security.db_sg_id

  client_name            = var.client_name
}
