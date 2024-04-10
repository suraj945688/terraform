resource "aws_instance" "MyIMG1" {
  ami           = "ami-09298640a92b2d12c"
  instance_type = "t2.micro"

  tags = {
    Name = "Testing Machine1"
	subnet_id = aws_subnet.public.id
  security_groups = [aws_security_group.allow_all.name]
  }
}
resource "aws_instance" "MyIMG2" {
  ami           = "ami-09298640a92b2d12c"
  instance_type = "t2.micro"

  tags = {
    Name = "Testing Machine2"
	subnet_id = aws_subnet.private.id
  security_groups = [aws_security_group.allow_all.name]
  }
}
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform_VPC"
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Private_Subnet"
  }
}
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Public_Subnet"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_vpc_attachment" "igw_attach" {
  vpc_id = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_vpc_endpoint_subnet_association" "sn_ec2" {
  vpc_endpoint_id = aws_vpc_endpoint.ec2.id
  subnet_id       = aws_subnet.sn.id
}

resource "aws_security_group" "allow_all" {
  vpc_id = aws_vpc.main.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}