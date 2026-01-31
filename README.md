
# Terraform AWS 3-Tier Architecture

##  Overview
This project provisions a secure and highly available **3-tier architecture on AWS** using **Terraform**.
The application layer is deployed in **private subnets** and exposed securely via an
**Application Load Balancer (ALB)**.

NGINX is installed on private EC2 instances and accessed from a browser through the ALB.

---

##  Architecture
**Request Flow:**

User → ALB (Public Subnet) → EC2 (Private Subnet) → RDS

### AWS Components
- VPC
- Public & Private Subnets
- Route Tables
- Internet Gateway
- NAT Gateway
- Application Load Balancer (ALB)
- EC2 Instances (Private Subnet)
- NGINX Web Server
- RDS (Database Layer)
- Security Groups

---

##  Tools & Technologies
- Terraform (Infrastructure as Code)
- AWS (VPC, EC2, ALB, RDS)
- NGINX
- Linux

---

##  Security Best Practices
- EC2 instances deployed in **private subnets**
- No direct public access to EC2
- Traffic allowed only through **ALB**
- Restricted access using **Security Groups**
- Terraform state and sensitive files excluded via `.gitignore`

---

##  Deployment

```bash
terraform init
terraform plan
terraform apply
