variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "ami_id" {}
variable "instance_type" {
  default = "t2.medium"
}
variable "key_name" {}
