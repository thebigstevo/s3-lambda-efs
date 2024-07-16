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
 
  depends_on = [module.vpc]
}

module "s3" {
  source     = "./modules/s3"
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc, module.lambda]
}
