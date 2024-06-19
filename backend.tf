terraform {
  cloud {
    organization = "bigspark"

    workspaces {
      name = "s3-lambda-efs"
    }
  }
}