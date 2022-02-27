variable "aws_region" {
    description = "AWS Region"
    default     = "us-west-2"
}
variable "cidr_block"{
    description = "VPC CIDR Block"

}

variable instance_tenancy {
    default = "default"
}

variable public_subnet {
    description = "Public Subnet Range"
    default     = "172.20.10.0/24"

}

variable private_subnet {
    description = "Private Subnet Range"
    default     = "172.20.20.0/24"
}

variable availability_zone {
    description = "Availablity Zone"
    default     = "us-west-2a"
}