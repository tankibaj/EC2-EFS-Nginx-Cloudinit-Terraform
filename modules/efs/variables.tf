variable "name" {
  type        = string
  description = "Name prefix of EFS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs for EFS"
}

variable "security_group_ids" {
  type        = list(string)
  default     = null
  description = "A list of security group IDs for EFS"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource"
}