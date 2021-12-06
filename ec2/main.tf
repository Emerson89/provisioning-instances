resource "random_pet" "name" {}
resource "aws_security_group" "allow_sec" {
  name        = "allow_sec"
  description = "SG terraform, allow_sec"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["${var.vpc_cidr_block}"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = random_pet.name.id
  }
}
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
}

data "aws_ami" "web"{
  most_recent = true

  owners = ["self"]

  filter {
    name = "name"

    values = ["packer-*"]
  }
}
resource "aws_instance" "main" {
  count                       = var.instance_count
  ami                         = data.aws_ami.web.id
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.generated_key.key_name
  user_data                   = <<EOF
	#! /bin/bash
  sudo yum install https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
	sudo systemctl start amazon-ssm-agent
  sudo systemctl enable amazon-ssm-agent
	EOF
  subnet_id                   = var.subnet_id
  security_groups             = ["${aws_security_group.allow_sec.id}"]

  ebs_optimized = var.ebs_optimized
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      device_name           = ebs_block_device.value.device_name
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
    }
  }

  tags = merge(
    {
      "Name" = var.instance_count > 1 ? format("%s-%d", var.name, count.index + 1) : var.name
    },
    var.tags,
  )

  volume_tags = merge(
    {
      "Name" = var.instance_count > 1 ? format("%s-%d", var.name, count.index + 1) : var.name
    },
    var.tags,
  )

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ${var.key_name}.pem"
  }

  credit_specification {
    cpu_credits = var.cpu_credits
  }

}