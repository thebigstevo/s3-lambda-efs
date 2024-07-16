module "vpc" {
  source       = "./modules/network"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id

}

module "lambda" {
  source     = "./modules/lambda"
  depends_on = [module.vpc]
}

module "efs" {
  source     = "./modules/efs"
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  public_subnet_3_id = module.vpc.public_subnet_3_id
  depends_on = [module.vpc]
}

module "s3" {
  source     = "./modules/s3"
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc, module.lambda]
}
