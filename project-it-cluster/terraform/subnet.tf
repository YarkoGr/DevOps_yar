resource "aws_subnet" "subnet-frpro" {
  vpc_id     = "${aws_vpc.vpc-frpro.id}"
  cidr_block = "10.0.0.0/16"

  map_public_ip_on_launch = "true"

  tags {
    Name = "Subnet"
  }
}
output "aws-id-subnet-frpro" {
  value = "${aws_subnet.subnet-frpro.id}"
}