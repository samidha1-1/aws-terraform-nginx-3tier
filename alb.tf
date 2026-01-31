resource "aws_lb" "alb" {
    name = "project-alb"
    internal = true 
    load_balancer_type = "application"
    security_groups = [aws_security_group.web_sg.id]
    subnets = [aws_subnet.public_subnet.id , aws_subnet.public_subnet-2.id]

    tags = {
        Name = "project-alb"
    }
}

resource "aws_lb_target_group" "tg" {
    name = "project-tg"
    port = 80 
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id 

    target_type = "instance"

    health_check {
      path                = "/"
      port                = "traffic-port"
      protocol            = "HTTP"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 5
      unhealthy_threshold = 2
      matcher             = "200"
    }
  
}

resource "aws_lb_target_group_attachment" "tg-attachment"{
    target_group_arn = aws_lb_target_group.tg.arn
    target_id        = aws_instance.private_instance.id
    port             = 80 


}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 80 
    protocol          = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.tg.arn 
    }
  
}
