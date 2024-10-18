## EC2
module "ec2" {
  source = "github.com/Emerson89/provisioning-instances.git//?ref=master"

  name                        = "ec2-terraform"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  key_name                    = "key"
  eip                         = false
  subnet_id                   = element(module.vpc.public_ids, 0)
  image_name                  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  owner                       = "099720109477"

  additional_rules_security_group = {

    ingress_rule_1 = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["172.16.3.10/32"]
      description = "SSH"
      type        = "ingress"
    },
  }

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
    Environment = "hml"
  }
}

module "vpc" {
  source = "github.com/Emerson89/vpc-aws-terraform.git?ref=v1.0.1"

  name                 = "my-vpc"
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Environment = "hml"
  }
  environment = "hml"

  private_subnets         = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  map_public_ip_on_launch = true

  create_nat = true
  create_igw = true

  igwname = "my-igw"
  natname = "my-nat"
  rtname  = "my-rt"
}
