resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "main-vpc"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-igw"
    }
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "eu-north-1a"
    map_public_ip_on_launch = true 

    tags = {
        Name = "public-subnet"
    }
  
}

resource "aws_subnet" "public_subnet-2" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.4.0/24"
    availability_zone       = "eu-north-1b"
    map_public_ip_on_launch = true 

    tags = {
        Name = "public-subnet2"
    }
  
}

resource "aws_subnet" "private_subnet-1" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "eu-north-1b"
    map_public_ip_on_launch = false
    
    tags = {
        Name = "private-subnet-1"
    }
}


resource "aws_subnet" "private_subnet-2" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.3.0/24"
    availability_zone       = "eu-north-1c"
    map_public_ip_on_launch = false

    tags = {
        Name = "private-subnet-2"
    }
  
}
