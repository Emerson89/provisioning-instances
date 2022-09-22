# Provisioning Ec2 using Terraform - AWS

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

```
main.tf

provider "aws" {
  region                      = var.region
  profile                     = var.profile
  skip_credentials_validation = true 
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    cloudwatch = "http://localhost:4566" <-- necessário para uso com localstack
    ec2        = "http://localhost:4566" <-- necessário para uso com localstack

  }
}
```

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
name           = "ec2 by terraform"
profile        = "local"
region         = "us-east-1"
ami            = "i-099392def6b574255"
instance_type  = "t3.micro"
key_name       = "my-key"
vpc_cidr_block = "0.0.0.0/0"
```
```
terraform init 
terraform plan -var-file="vars.tfvars"
terraform apply -var-file="vars.tfvars"
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | AMI ID used to provision the instance | `any` | `""` | yes |
| key\_name | Key Pair name to use for the instance | `string` | `""` | yes |
| region | Region where the instance will be provided | `string` | `""` | yes |
| profile | aws user profile | `string` | `""` | yes |
| vpc_cidr_block | CIDR IP VPC | `string` | `""`| yes |
| name | instance name | `any` | ` ` | yes |
| associate_public_ip_address | associar ip public | `bool`| `"true"`| no |
| cpu\_credits | Instance CPU credits option ("unlimited" or "standard")) | `string` | `"standard"` | no |
| ebs_size | ebs size instance | `number` | `8` | no |
| ebs\_optimized | Controls whether the instance will be provisioned as EBS-optimized | `bool` | `false` | no |
| instance\_count | Number of instances that will be provisioned | `number` | `1` | no |
| ingress_ports | Ingress port sg | `list` | `"[22]"` | no |
| engress_ports | Engress port sg | `list` | `"[0]"` | no |
| instance\_type | Type (class) of instance | `any` | `"t3.micro"` | no |
| subnet\_id | Subnet ID where the instance will be provisioned | `string` | `""` | no |
| vpc\_id | vpc id where the instance will be provisioned | `string` | `""` | no |
| tags | Instance and Volume Tag Map | `map` | `{}` | no |
| dev | Name device volume ebs | `string` | `/dev/sda1/` | no
| type | Type volume ebs | `string` | `gp2` | no

## Licence
GLPv3