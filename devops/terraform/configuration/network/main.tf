provider "aws" {
  region    = "${var.aws_region}"
}

#Create VPC

 resource "aws_vpc" "myvpc" {                   
   cidr_block       = var.cidr_block          
   instance_tenancy = var.instance_tenancy
     tags = {
    Name = "MyVpc"
  }
 }

#Create Internet Gateway and attach it to VPC

 resource "aws_internet_gateway" "my_igw" {    
    vpc_id =  aws_vpc.myvpc.id
    #vpc_id  = "vpc-0fa0387eb865bfad2"              
 }


# Create a Public Subnets

 resource "aws_subnet" "public_subnet" {    
   vpc_id =  aws_vpc.myvpc.id
   cidr_block = var.public_subnet
   availability_zone    = var.availability_zone
   tags = {
    Name = "public_subnet"
  }        
 }

#  Create a Private Subnet                  
 resource "aws_subnet" "private_subnet" {
   vpc_id =  aws_vpc.myvpc.id
   cidr_block = var.private_subnet 
   availability_zone    = var.availability_zone
   tags = {
    Name = "private_subnet"
  }          
 }

 # Route table for Public Subnet

 resource "aws_route_table" "public_route_table" {    
    vpc_id =  aws_vpc.myvpc.id
         route {
    cidr_block = "0.0.0.0/0"               
    gateway_id = aws_internet_gateway.my_igw.id
     }
 }

 # Route table Association with Public Subnet's

 resource "aws_route_table_association" "public_route_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
 }
# Creating Elastic IP
 resource "aws_eip" "elastic_ip" {
   vpc   = true
 }

 # Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "nat_gateway" {
   allocation_id = aws_eip.elastic_ip.id
   subnet_id = aws_subnet.public_subnet.id
 }

 #Route table for Private Subnet
 resource "aws_route_table" "private_route_table" {    
   vpc_id = aws_vpc.myvpc.id
   route {
   cidr_block = "0.0.0.0/0"             
   nat_gateway_id = aws_nat_gateway.nat_gateway.id
   }
 }

 # Route table Association with Private Subnet's
 resource "aws_route_table_association" "private_route_association" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id
 }