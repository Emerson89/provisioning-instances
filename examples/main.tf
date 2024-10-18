provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

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
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  key_name                    = "key"
  eip                         = false

  additional_policy = true

  policy_additional = [
    {
      name = "policy-test"
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
          {
            Effect = "Allow",
            Action = [
              "s3:PutObject",
              "s3:GetObject",
              "s3:DeleteObject",
              "s3:ListMultipartUploadParts",
              "s3:AbortMultipartUpload",
            ],
            Resource = [
              "arn:aws:s3:::test1234567678/*"
            ],
          },
        ],
      })
    }
  ]

  root_block_device = [
    {
      volume_type           = "gp3"
      volume_size           = 10
      delete_on_termination = true
      tags = {
        Name = "root-block"
      }
    },
  ]
  tags = {
    Environment = "Development"
  }
}
