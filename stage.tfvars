aws_region        = "us-east-1"
aws_access_key    = "AKIARRUBNDD26GK3CFAX"
aws_secret_key    = "+6payOuW1ND3gxDz1FhvucTWgCOvLYkZ1mnKjB5x"

# these are zones and subnets examples
availability_zones = ["us-east-1a", "us-east-1b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]

# these are used for tags
app_name        = "node-axoxs-app-stage"
app_environment = "stage"
certificate-arn =  "arn:aws:acm:us-east-1:106571831541:certificate/64e47648-ab90-4fb0-9b32-7fe209d1b288"
ecr  = "axoxs-stage"