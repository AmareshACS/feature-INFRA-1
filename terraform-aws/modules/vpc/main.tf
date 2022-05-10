resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env_name}-vpc"
  }
}


resource "aws_subnet" "web_subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet1_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.env_name}-subnet"
  }
}

resource "aws_subnet" "web_subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet2_cidr_block
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.env_name}-subnet"
  }
}
