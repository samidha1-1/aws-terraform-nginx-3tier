resource "aws_instance" "bastion" {
    ami = var.ami_instance
    instance_type = var.instance_type
    subnet_id = aws_subnet.public_subnet.id
    key_name = var.key_pair
    vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]
    associate_public_ip_address = true

    
    tags = {
        Name = "bastion-host"
    }

}

resource "aws_instance" "private_instance" {
    ami = var.ami_instance
    instance_type = var.instance_type
    subnet_id = aws_subnet.private_subnet-1.id
    key_name = var.key_pair
    security_groups = [aws_security_group.app_sg.id]

    user_data = file ("userdata.sh")

    tags = {
        Name = "private-app-server"
    }
  
}