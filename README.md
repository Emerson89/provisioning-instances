# Provisioning Ec2 using Terraform - AWS

![Badge](https://img.shields.io/badge/terraform-aws-red)

## Dependencies

- aws user with access-key secret-key

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

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0.0 |

## Providers

* provider.aws: version = "~> 3.9"
* provider.tls: version = "~> 2.2"

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | ID da AMI usada para provisionar a instância | `any` | `""` | yes |
| cpu\_credits | Opção de créditos de CPU da instância ("unlimited" ou "standard") | `string` | `"standard"` | no |
| ebs_size | ebs size instancia | `number` | `8` | no |
| ebs\_optimized | Controla se a instância será provisionada como EBS-optimized | `bool` | `false` | no |
| instance\_count | Número de instâncias que serão provisionadas | `number` | `1` | no |
| instance\_type | Tipo (classe) da instância | `any` | `"t3.micro"` | no |
| key\_name | Nome do Key Pair a ser usado para a instância | `string` | `""` | yes |
| name | Nome da instância | `any` | ` ` | yes |
| subnet\_id | ID da subnet onde a instância será provisionada | `string` | `""` | yes |
| vpc\_id | ID da vpc onde a instância será provisionada | `string` | `""` | yes |
| tags | Map de tags da instância e dos volumes | `map` | `{}` | no |
| region | Região onde será provionado a instância | `string` | `"us-east-1"` | yes |
| profile | Profile de usuario aws | `string` | `""` | yes |
| vpc_cidr_block | CIDR VPC | `string` | `""`| yes |
| dev | Name device volume ebs | `string` | `/dev/sda1/` | no
| type | Type volume ebs | `string` | `gp2` | no

## Licença
GLPv3