resource "aws_route_table" "route-table-frpro" {
  vpc_id = "${aws_vpc.vpc-frpro.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway-frpro.id}"
  }

  tags {
    Name = "Route Table"
  }
}
resource "aws_route_table_association" "route-table-association-frpro" {
  subnet_id      = "${aws_subnet.subnet-frpro.id}"
  route_table_id = "${aws_route_table.route-table-frpro.id}"
}