provider "aws" {
  region    = "${var.aws_region}"
}

resource "aws_instance" "ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  # subnet_id check the subnet_type value
  subnet_id                   = (var.subnet_type == "public" ? data.terraform_remote_state.subnet.outputs.public_subnet_id : data.terraform_remote_state.subnet.outputs.private_subnet_id)
  availability_zone           = var.availability_zone 
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = list(aws_security_group.sg.id)
  key_name                    = var.key_name
  user_data                   = var.user_data
  tags = {
    Name    = "${var.instance_name}-${lower(var.environment)}"

  }
}

