# Creating secuirty groups with no rules 

resource "aws_security_group" "web_sg" {
    name = "web-sg"
    vpc_id = aws_vpc.main.id
  
}

resource "aws_security_group" "app_sg" {
    name = "app-sg"
    vpc_id = aws_vpc.main.id
  
}

resource "aws_security_group" "db_sg" {
    name = "db-sg"
    vpc_id = aws_vpc.main.id
  
}

resource "aws_security_group" "bastion_host_sg" {
    name = "bastion-host-sg"
    vpc_id = aws_vpc.main.id
  
}


# Adding rules to web security group separately 

resource "aws_security_group_rule" "web_http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web_sg.id
  
}

resource "aws_security_group_rule" "app_from_web" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    source_security_group_id = aws_security_group.web_sg.id
    security_group_id = aws_security_group.app_sg.id
  
}

resource "aws_security_group_rule" "db_from_app" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    source_security_group_id = aws_security_group.app_sg.id
    security_group_id = aws_security_group.db_sg.id
  
}

resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["103.204.36.94/32"]
  security_group_id = aws_security_group.bastion_host_sg.id
}

resource "aws_security_group_rule" "app_ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_host_sg.id
  security_group_id        = aws_security_group.app_sg.id
}


# Outbound rules can be added similarly is neeeded 

resource "aws_security_group_rule" "all_egress_web" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web_sg.id
  
}

resource "aws_security_group_rule" "all_egress_app" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.app_sg.id
  
}

resource "aws_security_group_rule" "all_egress_db" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.db_sg.id
  
}

resource "aws_security_group_rule" "bastion_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_host_sg.id
}


# This does the same as above but in a single resource block for each security group 
# This throws an error such as cycle error because of the inter-dependency of security groups 

# # Security group for application tier 

# resource "aws_security_group" "web_sg" {
#     name = "web-sg"
#     description = "allow http and ssh traffic"
#     vpc_id = aws_vpc.main.id

#     ingress {
#         from_port = 80
#         to_port =  80 
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress {
#         from_port = 443
#         to_port = 443
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         security_groups = [aws_security_group.app_sg.id]
#     }
  
# }

# # Security group for application tier 

# resource "aws_security_group" "app_sg" {
#     name = "app-sg"
#     description = "allow ssh and mysql traffic"
#     vpc_id = aws_vpc.main.id

#     ingress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         security_groups = [aws_security_group.web_sg.id]

#     }

#     ingress {
#         from_port = 3306
#         to_port = 3306
#         protocol = "tcp"
#         security_groups = [aws_security_group.db_sg.id]
#     }

#     egress {
#         from_port = 3306
#         to_port = 3306
#         protocol = "tcp"
#         security_groups = [aws_security_group.db_sg.id]
#     }
# }

# # Security group for databse tier 

# resource "aws_security_group" "db_sg" {
#     name = "db-sg"
#     description = "Allow mysql traffic"
#     vpc_id = aws_vpc.main.id

#     ingress {
#         from_port = 3306
#         to_port = 3306
#         protocol = "tcp"
#         security_groups = [aws_security_group.app_sg.id]
#     }        
# }