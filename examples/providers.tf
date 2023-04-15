provider "aws" {
  region                      = "us-east-1"
  profile                     = "local"

  ## necessário para uso com localstack
  skip_credentials_validation = true 
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam        = "http://localhost:4566"
    ec2        = "http://localhost:4566"

  }
}