module "vpc" {
  source       = "./modules/network"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr

}

module "security_groups"{
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
  depends_on = [module.vpc]
}

# module "iam" {
#   source = "./modules/iam"
#   iam_role_name = var.iam_role_name
#   assume_role_policy = var.assume_role_policy
#   depends_on = [module.vpc]
# }

module "lambda" {
  source     = "./modules/lambda"
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  public_subnet_3_id = module.vpc.public_subnet_3_id
  efs_access_point_id = module.efs.efs_access_point_id
  depends_on = [module.vpc, module.security_groups, module.efs]
}

module "efs" {
  source     = "./modules/efs"
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  public_subnet_3_id = module.vpc.public_subnet_3_id
  efs_sg_id = module.security_groups.security_group_ids
  
  
  depends_on = [module.vpc]
}

module "s3" {
  source     = "./modules/s3"
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc, module.lambda]
}


