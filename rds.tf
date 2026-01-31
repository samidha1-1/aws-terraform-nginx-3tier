resource "aws_db_subnet_group" "db_subnet_group" {
    name = "main-db-subnet-group"
    subnet_ids = [
        aws_subnet.private_subnet-1.id,
        aws_subnet.private_subnet-2.id]  
}

resource "aws_db_instance" "rds_instance" {
    allocated_storage = 10 
    db_name = "mydatabase"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"

    username = "adminuser"
    password = "adminuser123"

    # parameter_group_name = "default.mysql.8.0"

    skip_final_snapshot = true 
    publicly_accessible = false 

    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.db_sg.id]

    tags = {
        Name = "main-rds-instance"
    }
  
}