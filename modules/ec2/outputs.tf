output "instance_ids" {
  value       = aws_instance.this.*.id
  description = "List of IDs of instances"
}

output "public_ip" {
  value       = aws_instance.this.*.public_ip
  description = "List of public IP addresses assigned to the instances, if applicable"

}

output "public_dns" {
  value       = aws_instance.this.*.public_dns
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
}