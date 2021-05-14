variable "name" {
  type        = string
  description = "Instance name"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to deploy"
}

variable "ami_id" {
  type        = string
  description = "Define a variable for AMI id"
}

variable "associate_public_ip" {
  type        = bool
  default     = true
  description = "Whether to associate a public IP address with an instance in a VPC"
}

variable "instance_type" {
  type        = string
  description = "Define a variable for instance type"
}

variable "availability_zone" {
  type        = list(string)
  description = "Define multiple availability zones"
}

variable "key_name" {
  type        = string
  default     = null
  description = "Key name of the Key Pair to use for the instance"
}

variable "monitoring" {
  type        = bool
  default     = false
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
}

variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "A list of subnet IDs for EC2 instances"
}

variable "security_group_ids" {
  type        = list(string)
  default     = null
  description = "A list of security group IDs to associate with EC2 instances"
}

variable "user_data" {
  type        = string
  default     = null
  description = "The user data to provide when launching the instance"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource"
}