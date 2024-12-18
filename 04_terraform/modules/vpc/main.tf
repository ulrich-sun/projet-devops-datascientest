resource "aws_vpc" "ds_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "ds_subnet" {
  vpc_id     = aws_vpc.ds_vpc.id
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = var.subnet_name
  }
  depends_on = [aws_vpc.ds_vpc]
}

resource "aws_internet_gateway" "ds_igw" {
  vpc_id = aws_vpc.ds_vpc.id
  tags = {
    Name = var.igw_name
  }
  depends_on = [aws_vpc.ds_vpc]
}

resource "aws_route_table" "ds_rt" {
  vpc_id = aws_vpc.ds_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ds_igw.id
  }
  tags = {
    Name = var.rt_name
  }
  depends_on = [aws_vpc.ds_vpc, aws_internet_gateway.ds_igw]
}

resource "aws_route_table_association" "ds_rta" {
  subnet_id      = aws_subnet.ds_subnet.id
  route_table_id = aws_route_table.ds_rt.id
  depends_on     = [aws_subnet.ds_subnet, aws_route_table.ds_rt]
}

