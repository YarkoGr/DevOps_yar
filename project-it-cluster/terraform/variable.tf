variable "access_key_id" {
  type = "string"
}
variable "secret_access_key" {
  type = "string"
}
variable "region" {
   default = "us-west-2"
}
variable "instance-type" {
     default =  "t2.micro"
}