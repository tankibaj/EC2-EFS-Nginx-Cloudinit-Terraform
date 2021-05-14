resource "random_pet" "this" {}

locals {
  tags = {
    Name        = random_pet.this.id
    Description = "Managed By Terraform"
  }
}

module "ec2_instance" {
  source = "./modules/ec2"

  name               = random_pet.this.id
  instance_count     = var.instance_count
  ami_id             = data.aws_ami.ubuntu.id
  instance_type      = var.instance_type
  availability_zone  = data.aws_availability_zones.available.names
  subnet_ids         = data.aws_subnet_ids.default.ids[*]
  security_group_ids = [module.ec2_security_group.security_group_id]
  key_name           = var.key_name
  user_data          = data.template_file.user_data.rendered

  tags = local.tags
}

module "efs" {
  source = "./modules/efs"

  name               = local.tags.Name
  subnet_ids         = data.aws_subnet_ids.default.ids[*]
  security_group_ids = [module.efs_security_group.security_group_id]

  tags = local.tags
}

module "ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "ec2-sg-${random_pet.this.id}"
  description = "Allow only HTTP and SSH publicly"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"] # ["http-80-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0" # Best security practice is to use only administrators public ip.
    }
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.tags
}


module "efs_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "efs-sg-${random_pet.this.id}"
  description = "Allow NFS within VPC"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = [data.aws_vpc.default.cidr_block]
  ingress_rules       = ["nfs-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.tags
}
