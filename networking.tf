
resource "aws_internet_gateway" "aws-igw" {
  vpc_id = aws_vpc.aws-vpc.id
  tags = {
    Name        = "${var.app_name}-igw"
    Environment = var.app_environment
  }

}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.aws-vpc.id
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${var.app_name}-private-subnet-${count.index + 1}"
    Environment = var.app_environment
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.aws-vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.app_name}-public-subnet-${count.index + 1}"
    Environment = var.app_environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    Name        = "${var.app_name}-routing-table-public"
    Environment = var.app_environment
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws-igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.public
  ]
  vpc = true
}

# Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.public[1].id
  tags = {
    Name = "Nat-Gateway_Project"
  }
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.aws-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private[1].id
  

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}