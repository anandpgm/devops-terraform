output "vpc_id" {
  description = "VPC ID associated with VPC"
  value = aws_vpc.myvpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.myvpc.cidr_block
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value = aws_subnet.private_subnet.id
}

output "private_subnet_cidr" {
  description = "Private Subnet ID"
  value = aws_subnet.private_subnet.cidr_block
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value = aws_subnet.public_subnet.id
}

output "public_subnet_cidr" {
  description = "Public Subnet ID"
  value = aws_subnet.public_subnet.cidr_block
}