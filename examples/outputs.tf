output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = module.ec2.public_dns
}

output "tags" {
  description = "List of tags"
  value       = module.ec2.tags
}
