resource "aws_internet_gateway" "gateway-frpro" {
  vpc_id = "${aws_vpc.vpc-frpro.id}"

  tags {
    Name = "Intenet Gateway"
  }
}