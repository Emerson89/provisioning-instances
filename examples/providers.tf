provider "aws" {
  region  = ""
  profile = ""

  ## necessário para uso com localstack
  #skip_credentials_validation = true
  #skip_metadata_api_check     = true
  #skip_requesting_account_id  = true

  #sendpoints {
  #  iam = "http://localhost:4566"
  #  ec2 = "http://localhost:4566"

  #}
}