resource "random_id" "creation_token" {
  byte_length = 8
  prefix      = "${var.name}-"
}

resource "aws_efs_file_system" "this" {
  creation_token = random_id.creation_token.hex
  encrypted      = true

  tags = var.tags

}

resource "aws_efs_mount_target" "this" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_group_ids
}