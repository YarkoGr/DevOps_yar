resource "aws_vpc" "vpc-frpro" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "VPC"
  }
}