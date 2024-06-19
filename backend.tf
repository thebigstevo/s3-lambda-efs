terraform {
  cloud {
    organization = "thebigstevo"

    workspaces {
      name = "s3-lambda-efs"
    }
  }
}