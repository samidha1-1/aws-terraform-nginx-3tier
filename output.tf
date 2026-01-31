output "bastion_public_ip" {
    value = aws_instance.bastion.public_ip
  
}

output "rds_endpoint" {
    value = aws_db_instance.rds_instance.endpoint 
  
}

output "aws_lb" {
    value = aws_lb.alb.dns_name
  
}

output "private_ec2" {
    value = aws_instance.private_instance.private_ip
}