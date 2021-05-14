variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "Define aws region"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Number of EC2 instances to deploy"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Define instance type"
}

variable "key_name" {
  type        = string
  default     = "thenaim" # Please use your own key name
  description = "Key name of the Key Pair to use for the instance"
}

variable "efs_name" {
  type        = string
  default     = "hello-world-efs"
  description = "Name prefix of EFS"
}