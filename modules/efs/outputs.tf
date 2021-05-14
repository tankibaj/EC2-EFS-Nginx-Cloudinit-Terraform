output "efs_id" {
  value       = aws_efs_mount_target.this[0].id
  description = "The ID of the mount target"
}

output "dns_name" {
  value       = aws_efs_mount_target.this[0].dns_name
  description = "The DNS name for the EFS file system."
}

output "mount_target_dns_name" {
  value       = aws_efs_mount_target.this[0].mount_target_dns_name
  description = "The DNS name for the given subnet/AZ per"
}

output "network_interface_id" {
  value       = aws_efs_mount_target.this[0].network_interface_id
  description = "The ID of the network interface that Amazon EFS created when it created the mount target"
}