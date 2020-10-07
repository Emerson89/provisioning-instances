output "public_dns" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.git.*.public_dns
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = aws_instance.git.*.security_groups
}

output "tags" {
  description = "List of tags of instances"
  value       = aws_instance.git.*.tags
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = aws_instance.git.*.volume_tags
}