provider "aws" {
  profile = var.profile
  region  = var.aws_region

  ##Necessario somente para localstack
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam = "http://localhost:4566"
    ec2 = "http://localhost:4566"

  }
}