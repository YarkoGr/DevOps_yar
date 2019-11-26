provider "aws" {
  access_key = "${var.access_key_id}"
  secret_key = "${var.secret_access_key}"
  region     = var.region

}
resource "aws_instance" "first-project" {
  ami           = "ami-0a85857bfc5345c38"
  instance_type = var.instance-type
}