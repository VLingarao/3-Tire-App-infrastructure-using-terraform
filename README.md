# Multi-Region AWS Warm-Standby DR Architecture (Terraform)

This project deploys a production-grade **Disaster Recovery architecture** across 
two AWS regions (us-east-1 & us-west-2) using **Terraform**.

## 🚀 Features
- Multi-AZ VPC design  
- Public, Web, App & DB subnets  
- Bastion Hosts for secure SSH  
- Auto Scaling Group + Application Load Balancer  
- RDS MySQL + Cross-Region Read Replica  
- AWS Backup + Cross-Region Backup  
- CloudFront CDN + AWS WAF  
- Route 53 DNS failover  
- Fully automated via Terraform (modules, variables, remote backend)

## 🛠️ Tech Used
Terraform, AWS EC2, VPC, RDS, ALB, ASG, NAT, CloudWatch, CloudFront, WAF, Backup Vault

## ❤️ Author
Venkata Lingarao Andugulapati  
Portfolio: https://venkata-lingarao-portfolio.netlify.app  
LinkedIn: https://linkedin.com/in/venkata-lingarao-andugulapati  
