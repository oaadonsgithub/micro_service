variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "ami_id" {}
variable "instance_type" {
  default = "t2.medium"
}
variable "key_name" {}
variable "lb_target_group_443_name" {
  description = "Name prefix for the 443 target group"
  type        = string
}
variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}
variable "aws_account_region" {
  description = "AWS region"
  type        = string
}
variable "region" {
  description = "AWS region"
  type        = string
}

variable "active_color" {
  description = "The active deployment color: 'blue' or 'green'"
  type        = string
  default     = "blue"
}


variable "certificate_arn" {
  description = "The ARN of the SSL/TLS certificate for the HTTPS listener"
  type        = string
}
