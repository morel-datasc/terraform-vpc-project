provider "aws" {
  region = "ca-central-1"
}

resource "aws_vpc" "create_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "morel-vpc"
  }
}

resource "aws_subnet" "create_prv_subnet" {
    vpc_id = aws_vpc.create_vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "morel-private-subnet"
    }
}

resource "aws_subnet" "create_pub_subnet" {
    vpc_id = aws_vpc.create_vpc.id
    cidr_block = "10.0.101.0/24"

    tags = {
        Name = "morel-public-subnet"
    }
}

resource "aws_internet_gateway" "create_igw" {
    vpc_id = aws_vpc.create_vpc.id

    tags = {
        Name = "morel-igw"
    }
}

resource "aws_igw_attachment" "attach_igw" {
    vpc_id = aws_vpc.create_vpc.id
    internet_gateway_id = aws_internet_gateway.create_igw.id
}

resource "aws_route_table" "create_route_table" {
    vpc_id = aws_vpc.create_vpc.id

    route {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.create_igw.id
    }

    tags = {
        Name = "morel-route-table"
    }
}

resource "aws_route_table_association" "associate_route_table" {
    subnet_id = aws_subnet.create_pub_subnet.id
    route_table_id = aws_route_table.create_route_table.id
}