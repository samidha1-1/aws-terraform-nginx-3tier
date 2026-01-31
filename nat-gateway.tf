resource "aws_eip" "nat_ip" {
    domain = "vpc"

}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_ip.id
    subnet_id = aws_subnet.public_subnet.id

    depends_on = [ aws_internet_gateway.igw ]
  
}