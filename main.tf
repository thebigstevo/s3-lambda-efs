module "vpc" {
  source       = "./modules/network"
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  vpc_id = module.vpc.vpc_id

}

module "security_groups"{
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
  depends_on = [module.vpc]
}

module "iam" {
  source = "./modules/iam"

}

module "efs" {
  source     = "./modules/efs"
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  public_subnet_3_id = module.vpc.public_subnet_3_id
  efs_sg_id = module.security_groups.efs_security_group_ids
  
  
  depends_on = [module.vpc]
}

module "s3" {
  source     = "./modules/s3"
  vpc_id     = module.vpc.vpc_id
  route_table_id= module.vpc.public_route_table_id
  lambda_arn = module.lambda.lambda_arn
  depends_on = [module.vpc]
}



# module "lambda" {
#   source     = "./modules/lambda"
#   public_subnet_1_id = module.vpc.public_subnet_1_id
#   public_subnet_2_id = module.vpc.public_subnet_2_id
#   public_subnet_3_id = module.vpc.public_subnet_3_id
#   efs_access_point_arn = module.efs.efs_access_point_arn
#   lambda_security_group_ids = module.security_groups.lambda_security_group_ids
#   s3_bucket_arn = module.s3.s3_bucket_arn
#   lambda_role_arn = module.iam.lambda_role_arn

#   depends_on = [module.efs, module.iam, module.s3]
# }


