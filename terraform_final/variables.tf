# variables.tf
variable "region" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "aws_account_id" {}
variable "certificate_arn" {}
variable "active_color" {}