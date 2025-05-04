variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-west-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
