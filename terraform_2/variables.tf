variable "name" {}
variable "use_name_prefix" { default = false }
variable "instance_name" {}
variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}
variable "wait_for_capacity_timeout" {}
variable "health_check_type" {}
variable "vpc_zone_identifier" {}

variable "initial_lifecycle_hooks" {
  type = list(object({
    name                 = string
    default_result       = string
    heartbeat_timeout    = number
    lifecycle_transition = string
    notification_metadata = string
  }))
  default = []
}

variable "tags" { type = map(string) }

variable "launch_template_name" {}
variable "image_id" {}
variable "instance_type" {}
variable "user_data" {}
variable "ebs_optimized" { default = false }
variable "enable_monitoring" { default = false }

variable "create_iam_instance_profile" { default = true }
variable "iam_role_name" {}
variable "iam_role_path" {}
variable "iam_role_description" {}
variable "iam_role_tags" { type = map(string) }
variable "iam_role_policies" { type = map(string) }

variable "metadata_options" {
  type = object({
    http_endpoint               = string
    http_tokens                 = string
    http_put_response_hop_limit = number
    instance_metadata_tags      = string
  })
}

variable "network_interfaces" { type = any }
variable "tag_specifications" { type = list(any) }