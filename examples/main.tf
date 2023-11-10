provider "aws" {
  region  = "us-east-1"
  profile = "local"

  ## necessário para uso com localstack
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam = "http://localhost:4566"
    ec2 = "http://localhost:4566"

  }
}

## EC2
module "ec2" {
  source = "github.com/Emerson89/provisioning-instances.git//?ref=master"

  name                        = "ec2-terraform"
  vpc_security_group_ids      = ["sg-abcabcabc"]
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  key_name                    = "key"
  eip                         = false
  subnet_id                   = ["subnet-abcabcabcabc"]
  image_name                  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  owner                       = "099720109477"

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 10
      #delete_on_termination = false
      tags = {
        Name = "root-block"
      }
    },
  ]
  tags = {
    Environment = "Development"
  }
}
