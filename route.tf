resource "aws_route_table" "rt1" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public-route-table"
    }
  
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "private-route-table"
    }
  
}


resource "aws_route_table_association" "rt_asso_1" {
    subnet_id = aws_subnet.public_subnet.id 
    route_table_id = aws_route_table.rt1.id 
  
}

resource "aws_route" "private_nat_rt" {
    route_table_id = aws_route_table.private_rt.id 
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  
}

resource "aws_route_table_association" "private_asso_1" {
    subnet_id = aws_subnet.private_subnet-1.id
    route_table_id = aws_route_table.private_rt.id
  
}

resource "aws_route_table_association" "private_asso_2" {
    subnet_id = aws_subnet.private_subnet-2.id
    route_table_id = aws_route_table.private_rt.id
  
}

