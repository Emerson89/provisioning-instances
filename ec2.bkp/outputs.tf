output "public_dns" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.main.*.public_dns
}

output "vpc_security_group_ids" {
  description = "Lista dos IDs dos security groups vinculados às instâncias"
  value       = aws_instance.main.*.security_groups
}

output "tags" {
  description = "List of tags of instances"
  value       = aws_instance.main.*.tags
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = aws_instance.main.*.volume_tags
}