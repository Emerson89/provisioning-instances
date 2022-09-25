# Provisioning ec2 using Terraform - AWS

![Badge](https://img.shields.io/badge/terraform-aws-red)

## Dependencies

- aws user with access-key secret-key
- Python3

## Usando localstack

```
pip install localstack
localstack start -d
localstack status services
```
```
aws configure --profile local
AWS Access Key ID [****************ocal]: local
AWS Secret Access Key [****************ocal]: local
Default region name [us-east-1]: 
Default output format [json]: 
```
Para mais informações segue repo localstack: https://github.com/localstack/localstack

## Comando aws-cli
```
export AWS_PROFILE=local
aws ec2 --endpoint-url=http://localhost:4566 describe-instances --filters Name=tag-key,Values=Name --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}'
```
Para simular usando script em python segue exemplo *instances.py* requer boto3

```hcl

## provider

provider "aws" {
  region                      = var.region
  profile                     = var.profile

  ## necessário para uso com localstack
  skip_credentials_validation = true 
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam        = "http://localhost:4566"
    ec2        = "http://localhost:4566"

  }
}
```
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.2.9 |

## Providers

* provider.aws: version = "~> 3.9"
* provider.tls: version = "~> 2.2"

## Terraform backend s3

Create a s3 to store tfstate

```hcl
   backend "s3" {
    bucket  = "s3-tfstates-terraform"
    key     = "terraform-ec2.tfstate"
    region  = "us-east-1"
    profile = "local"
  }
```
## Single instance
```hcl
module "ec2" {
  source = "../ec2"

  name                        = "ec2 by terraform"
  ami                         = data.aws_ami.img.id
  instance_type               = "t3.micro"
  subnet_id                   = ""
  vpc_id                      = ""
  associate_public_ip_address = true
  key_name                    = "key-pem"
  eip                         = "false"

  ingress = {
    "ingress_rule_1" = {
      "from_port"   = "80"
      "to_port"     = "80"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    "ingress_rule_2" = {
      "from_port"   = "22"
      "to_port"     = "22"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  }

  enable_volume_tags = false
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
      tags = {
        Name = "root-block"
      }
    },
  ]

  tags = { Environment = "hml" }
}

data "aws_ami" "img" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/*"]
  }
}
```
## Multiple instances
```hcl
module "ec2" {
  source = "../ec2"

  name                        = "ec2 by terraform"
  ami                         = data.aws_ami.img.id
  instance_type               = "t3.micro"
  instance_count              = 3
  subnet_id                   = ""
  vpc_id                      = ""
  associate_public_ip_address = true
  key_name                    = "key-pem"
  eip                         = "false"

  ingress = {
    "ingress_rule_1" = {
      "from_port"   = "80"
      "to_port"     = "80"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    "ingress_rule_2" = {
      "from_port"   = "22"
      "to_port"     = "22"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  }

  enable_volume_tags = false
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
      tags = {
        Name = "root-block"
      }
    },
  ]

  tags = { Environment = "hml" }
}

data "aws_ami" "img" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/*"]
  }
}
```
```
Em examples/ execute

terraform init 
terraform plan 
terraform apply

PEM key is saved in the current directory
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| data ami | AMI ID used to provision the instance | `any` | `"ubuntu/*"` | no |
| key\_name | Key Pair name to use for the instance | `string` | `"key-pem"` | no |
| region | Region where the instance will be provided | `string` | `"us-east-1"` | no |
| profile | aws user profile | `string` | `"local"` | no |
| name | instance name | `any` | `ec2 by terraform` | no |
| associate_public_ip_address | associar ip public | `bool`| `"true"`| no |
| eip | associar ip elastic | `bool`| `"false"`| no |
| ingress | ingress rules security group | `map` | `{}` | yes |
| egress | egress rules security group | `map` | `{ "engress_rule" = { "from_port" = "-1" "to_port" = "0" "protocol" = "tcp" "cidr_blocks" = ["0.0.0.0/0"]}` | no |
| cpu\_credits | Instance CPU credits option ("unlimited" or "standard")) | `string` | `""` | no |
| availability_zone | zones availability | `string` | `null` | no
| disable_api_termination | If true, enables EC2 Instance Termination Protection | `bool` | `null` | no
| ebs_block_device | Additional EBS block devices to attach to the instance | `list` | `[]` | no
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no
| ephemeral_block_device | Customize Ephemeral (also known as Instance Store) volumes on the instance | `list` | `[]` | no
| timeouts | Define maximum timeout for creating, updating, and deleting EC2 instance resources | `map` | `{}` | no
| vpc_security_group_ids | A list of security group IDs to associate with | `list` | `null` | no
| enable_volume_tags | Whether to enable volume tags (if enabled it conflicts with root_block_device tags) | `bool` | `true` | no
| volume_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map` | `{}` | no
| launch_template | Specifies a Launch Template to configure the instance | `map` | `null` | no
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no
| network_interface | Customize network interfaces to be attached at instance boot time | `list` | `[]` | no
| private_ip | Private IP address to associate with the instance in a VPC | `string` | `null` | no
| root_block_device | "Customize details about the root block device of the instance. See Block Devices below for details | `list` | `[]` | yes
| subnet_id | The VPC Subnet ID to launch in | `map` | `{}` | no
| user_data | The user data to provide when launching the instance | `string` | `null` | no
| user_data_base64 | Can be used instead of user_data to pass base64-encoded binary data directly | `string` | `null` | no
| sgname | Name to be used on security-group created | `string` | `sg ec2 by terraform` | no
| description | Description of security group | `string` | `Security Group managed by Terraform` | no
| vpc_id | ID of the VPC where to create security group | `string` | `""` | no
| ebs\_optimized | Controls whether the instance will be provisioned as EBS-optimized | `bool` | `false` | no |
| instance\_count | Number of instances that will be provisioned | `number` | `1` | no |
| instance\_type | Type (class) of instance | `any` | `"t3.micro"` | no |
| subnet\_id | Subnet ID where the instance will be provisioned | `string` | `""` | no |
| vpc\_id | vpc id where the instance will be provisioned | `string` | `""` | no |
| tags | Instance Tag Map | `map` | `{}` | no |

## Licence
GLPv3