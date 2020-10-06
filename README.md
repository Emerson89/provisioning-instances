# Provisioning Ec2 using Terraform - AWS

![Badge](https://img.shields.io/badge/terraform-aws-red)

## Dependencies
![Badge](https://img.shields.io/badge/AWS%20-Access--key-blue)

## Terraform Module - AWS - EC2

Example module for provisioning, pay attention to the PATH of the cloned repository on your machine in source

```hcl
module "ec2" {
  source = "../../provider-instance/"

  profile = "Custom_profile"
  ami = "ami-02e98f78"
  instance_type = "t2.micro"
  region = "us-east-1"
  key_name = "my-key"

  vpc_id = "vpc-id"
  subnet_id = "subnet-id"
    
  ebs_block_device = [{
    device_name         = "/dev/sda1"
    volume_type         = "standard"
    volume_size         = 10
  }]
}
```
```
terraform init
terraform plan
terraform apply
```
### CPU Credits

If the instance is of type T2 or T3, the variable `cpu_credits` can be used
to enable [T2 / T3 Unlimited] mode[t-unlimited-docs]:

```hcl
module "ec2" {
  # ...

  cpu_credits = "unlimited"
}
```
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | ID da AMI usada para provisionar a instância | `any` | `""` | yes |
| associate\_public\_ip\_address | Vincula um IP público à instância | `bool` | `false` | no |
| cpu\_credits | Opção de créditos de CPU da instância ("unlimited" ou "standard") | `string` | `"standard"` | no |
| disable\_api\_termination | Controla a proteção de destruição (terminate) da instância | `bool` | `true` | no |
| ebs\_block\_device | Lista com maps de configuração de volumes adicionais da instância | `list` | `[]` | yes |
| ebs\_optimized | Controla se a instância será provisionada como EBS-optimized | `bool` | `false` | no |
| instance\_count | Número de instâncias que serão provisionadas | `number` | `1` | no |
| instance\_type | Tipo (classe) da instância | `any` | `""` | yes |
| key\_name | Nome do Key Pair a ser usado para a instância | `string` | `""` | yes |
| name | Nome da instância | `any` | n/a | yes |
| root\_block\_device | Lista com maps de configuração do volume raiz da instância | `list` | n/a | no |
| subnet\_id | ID da subnet onde a instância será provisionada | `string` | `""` | yes |
| vpc\_id | ID da vpc onde a instância será provisionada | `string` | `""` | yes |
| tags | Map de tags da instância e dos volumes | `map` | `{}` | no |
| Region | Região onde será provionado a instância | `string` | `""` | yes |

## Licença
GLPv3