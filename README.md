# Provisioning Ec2 using Terraform - AWS

![Badge](https://img.shields.io/badge/terraform-aws-red)

## Dependencies

- aws user with access-key secret-key

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0.0 |

## Providers

* provider.aws: version = "~> 3.9"
* provider.tls: version = "~> 2.2"

## Terraform variable file

Example file .tfvars for provisioning

```hcl
name = "ec2 by terraform"
profile = "CUSTOMPROFILE"
ami = "ami-abcde"
instance_type = "t3.micro"
region = "us-east-1"
key_name = "my-key"
vpc_id = "vpc-abcde"  
subnet_id = "subnet-abcde"
vpc_cidr_block = "0.0.0.0/0"
```
```
terraform init 
terraform plan -var-file="teste.tfvars"
terraform apply -var-file="teste.tfvars"
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | AMI ID used to provision the instance | `any` | `""` | yes |
| cpu\_credits | Instance CPU credits option ("unlimited" or "standard")) | `string` | `"standard"` | no |
| ebs_size | ebs size instance | `number` | `8` | no |
| ebs\_optimized | Controls whether the instance will be provisioned as EBS-optimized | `bool` | `false` | no |
| instance\_count | Number of instances that will be provisioned | `number` | `1` | no |
| instance\_type | Type (class) of instance | `any` | `"t3.micro"` | no |
| key\_name | Key Pair name to use for the instance | `string` | `""` | yes |
| name | instance name | `any` | ` ` | yes |
| subnet\_id | Subnet ID where the instance will be provisioned | `string` | `""` | yes |
| vpc\_id | vpc id where the instance will be provisioned | `string` | `""` | yes |
| tags | Instance and Volume Tag Map | `map` | `{}` | no |
| region | Region where the instance will be provided | `string` | `""` | yes |
| profile | aws user profile | `string` | `""` | yes |
| vpc_cidr_block | CIDR VPC | `string` | `""`| yes |
| dev | Name device volume ebs | `string` | `/dev/sda1/` | no
| type | Type volume ebs | `string` | `gp2` | no

## Licence
GLPv3