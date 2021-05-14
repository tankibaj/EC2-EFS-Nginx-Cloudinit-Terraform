
output "ec2_public_ip" {
  value       = module.ec2_instance.public_ip
  description = "List of public IP addresses assigned to the instances, if applicable"
}

output "efs_dns" {
  value       = module.efs.dns_name
  description = "The DNS name for the EFS file system."
}