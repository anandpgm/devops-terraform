provider "aws" {
  region    = "${var.aws_region}"
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id              = var.subnet_id
  availability_zone      = var.availability_zone 
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = list(aws_security_group.sg.id)

  # The name of our SSH keypair we created above.
  key_name = var.key_name

  user_data            = var.user_data

  tags = {
    Name           = "${var.instance_name}-${lower(var.environment)}"

  }
}

resource "aws_security_group" "sg" { 

  name_prefix = "${var.instance_name}-Security-Group"
  description = "Security group for ${var.instance_name} instance"

  vpc_id = "vpc-0f43a614ee95895f3"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "sg_ingress_22" {
   
  security_group_id = aws_security_group.sg.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = var.ingress_22_cidr_blocks

  lifecycle {
    create_before_destroy = true
  }
} 

 resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  security_group_id = aws_security_group.sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}