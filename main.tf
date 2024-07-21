module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  availability_zones = var.availability_zones
  subnet_cidrs = var.subnet_cidrs
}

module "security_groups" {
  source     = "./modules/security-groups"
  vpc_id     = module.vpc.vpc_id
  vpc_cidr   = var.vpc_cidr
  depends_on = [module.vpc]
}

module "iam" {
  source               = "./modules/iam"
  s3_bucket_arn        = module.s3.s3_bucket_arn
  efs_access_point_arn = module.efs.efs_access_point_arn

  depends_on = [module.s3, module.efs]
}

module "efs" {
  source            = "./modules/efs"
  public_subnet_ids = module.vpc.public_subnet_ids
  efs_sg_id         = module.security_groups.efs_security_group_ids
  depends_on        = [module.vpc]
}

module "s3" {
  source         = "./modules/s3"
  vpc_id         = module.vpc.vpc_id
  route_table_id = module.vpc.public_route_table_id
  depends_on     = [module.vpc]
}

module "lambda" {
  source                    = "./modules/lambda"
  public_subnet_ids         = module.vpc.public_subnet_ids # List of subnet IDs
  efs_access_point_arn      = module.efs.efs_access_point_arn
  lambda_security_group_ids = module.security_groups.lambda_security_group_ids
  s3_bucket_arn             = module.s3.s3_bucket_arn
  lambda_role_arn           = module.iam.lambda_role_arn
  s3_bucket_id              = module.s3.s3_bucket_id
  depends_on                = [module.efs, module.iam, module.s3]
}


module "ec2" {
  source                 = "./modules/ec2"
  ec2_security_group_ids = module.security_groups.ec2_security_group_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  depends_on = [ module.vpc, module.efs ]
}
