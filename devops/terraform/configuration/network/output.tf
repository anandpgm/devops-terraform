output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "igw_id" {
 value = aws_internet_gateway.my_igw.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}