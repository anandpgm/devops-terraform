resource "aws_security_group" "sg" { 

  name_prefix = "${var.instance_name}-Security-Group"
  description = "Security group for ${var.instance_name} instance"

  vpc_id = "vpc-03a8272487828a044"

  lifecycle {
    create_before_destroy = true
  }
}

# Allowing port 22 ingress
resource "aws_security_group_rule" "sg_ingress_22" {
   
  description       = "SSH Port"  
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

# Allowing port 8080 ingress

resource "aws_security_group_rule" "sg_ingress_8080" {
  description       = "Jenkins Port"
  count             = var.sg_ingress_8080_allow ? 1 : 0 
  security_group_id = aws_security_group.sg.id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = var.ingress_8080_cidr_blocks

  lifecycle {
    create_before_destroy = true
  }
} 

resource "aws_security_group_rule" "sg_ingress_80" {
  description       = "Application Port"
  count             = var.sg_ingress_80_allow ? 1 : 0 
  security_group_id = aws_security_group.sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = var.ingress_80_cidr_blocks

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
