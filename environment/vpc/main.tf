resource "aws_vpc" "this" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "this_public" {
  vpc_id = "${aws_vpc.this.id}"
  cidr_block = "${var.subnets_cidrs["public"]}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.aws_region}a"
  tags {
    Name = "${var.project_name}-public-subnet"
  }
}

resource "aws_subnet" "this_private" {
  vpc_id = "${aws_vpc.this.id}"
  cidr_block = "${var.subnets_cidrs["private"]}"
  map_public_ip_on_launch = "false"
  availability_zone = "${var.aws_region}a"
  tags {
    Name = "${var.project_name}-private-subnet"
  }
}

resource "aws_internet_gateway" "this_gateway" {
  vpc_id = "${aws_vpc.this.id}"
  tags {
    Name = "${var.project_name}-internet-gateway"
  }
}

resource "aws_route_table" "this_route_table" {
  vpc_id = "${aws_vpc.this.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this_gateway.id}"
  }
  tags {
    Name = "${var.project_name}-route-table"
  }
}

resource "aws_route_table_association" "this_route_table_association" {
  subnet_id = "${aws_subnet.this_public.id}"
  route_table_id = "${aws_route_table.this_route_table.id}"
}
