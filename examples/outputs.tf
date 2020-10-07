output "public_dns" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.ec2.public_dns
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = module.ec2.security_groups
}

output "tags" {
  description = "List of tags of instances"
  value       = module.ec2.tags
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.ec2.volume_tags
}
