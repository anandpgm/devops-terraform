variable aws_region {
    default = "us-west-2"
}

variable ami {
    default = "ami-074251216af698218"
}

variable instance_type {
    default = "t2.micro"
}

variable availability_zone {
    default = "us-west-2a"
}

variable user_data {

}

variable associate_public_ip_address {
    default = false
}
variable instance_name {

}
variable environment {

}

variable "default_sgs" {
  type = list(string)
  default = null
}

variable subnet_id {

}

variable key_name {
    default = null
}
variable ingress_22_cidr_blocks {
    type = list(string)

}