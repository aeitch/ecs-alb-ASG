aws_region        = "us-east-1"
aws_access_key    = "AKIARRUBNDD26GK3CFAX"
aws_secret_key    = "+6payOuW1ND3gxDz1FhvucTWgCOvLYkZ1mnKjB5x"

# these are zones and subnets examples
availability_zones = ["us-east-1a", "us-east-1b"]
public_subnets     = ["10.10.90.0/24", "10.10.80.0/24"]
private_subnets    = ["10.10.3.0/24", "10.10.4.0/24"]

# these are used for tags
app_name        = "node-axoxs-app-prod"
app_environment = "prod"
certificate-arn = "arn:aws:acm:us-east-1:106571831541:certificate/b858f48c-e582-4f14-9a64-f4233196a972"
ecr  = "axoxs-prod"