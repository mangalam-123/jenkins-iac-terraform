
resource "aws_vpc" "Demo-vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name": "Custom-vpc"
  }
}

resource "aws_internet_gateway" "Demo-igw" {
    vpc_id = aws_vpc.Demo-vpc.id

    tags = {
      "Name" : "Custom-igw"
    }
  
}

resource "aws_subnet" "Demo-pub-subnet" {
    count = length(var.pub_subnet_cidr)
    vpc_id = aws_vpc.Demo-vpc.id
    cidr_block = element(var.pub_subnet_cidr, count.index)
    availability_zone = element(var.Az, count.index)
    map_public_ip_on_launch = true
  
  tags = {
    "Name" : "Custom-pub-subnet"
  }
}


resource "aws_subnet" "Demo-prvt-subnet" {
    count = length(var.prvt_subnet_cidr)
    vpc_id = aws_vpc.Demo-vpc.id
    cidr_block = element(var.prvt_subnet_cidr, count.index)
    availability_zone = element(var.Az, count.index)
  
  tags = {
    "Name" : "Custom-database-subnet"
  }
}

resource "aws_subnet" "Demo-database-subnet" {
    count = length(var.database_subnet_cidr)
    vpc_id = aws_vpc.Demo-vpc.id
    cidr_block = element(var.database_subnet_cidr, count.index)
    availability_zone = element(var.Az, count.index)
    map_public_ip_on_launch = true
  
  tags = {
    "Name" : "Custom-pub-subnet"
  }
}



resource "aws_route_table" "Demo-pub-rt" {
  vpc_id = aws_vpc.Demo-vpc.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Demo-igw.id
  }

  tags = {
    "Name" : "Custom-pub-rt"
  }
}


resource "aws_route_table" "Demo-prvt-rt" {
  vpc_id = aws_vpc.Demo-vpc.id

  tags = {
    "Name" : "Custom-prvt-rt"
  }
}



resource "aws_route_table_association" "Demo-pub-rt-subnet" {
   count = length(var.pub_subnet_cidr)
   subnet_id = element(aws_subnet.Demo-pub-subnet.*.id, count.index)
   route_table_id = aws_route_table.Demo-pub-rt.id
}

resource "aws_route_table_association" "Demo-prvt-rt-subnet" {
   count = length(var.prvt_subnet_cidr)
   subnet_id = element(aws_subnet.Demo-prvt-subnet.*.id, count.index)
   route_table_id = aws_route_table.Demo-prvt-rt.id
}



resource "aws_route_table_association" "Demo-database-rt-subnet" {
   count = length(var.database_subnet_cidr)
   subnet_id = element(aws_subnet.Demo-database-subnet.*.id, count.index)
   route_table_id = aws_route_table.Demo-prvt-rt.id
}




