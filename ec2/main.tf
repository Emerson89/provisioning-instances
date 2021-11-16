resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_instance" "main" {
	count = var.instance_count
  ami = var.ami
	instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  associate_public_ip_address = "true"
  subnet_id = var.subnet_id
  vpc_security_group_ids = flatten([var.security_groups])

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