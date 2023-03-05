variable "vpc_id" {
  description = "VPC Id"
  type = string
}

variable "cluster_name" {
  description = "Name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
  type        = string
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = map(string)
  default     = {}
}

variable "service_map" {
  description = "Service map "
  type        = map(object({
    is_public     = bool
    name          = string
    image         = string
    cpu           = number
    memory        = number
    containerPort = number
    hostPort      = number
    essential     = bool
  }))
}

variable "private_subnets" {
  description = "VPC private subnet ids"
  type = list(string)
  default = []
}

variable "public_subnets" {
  description = "VPC public subnet ids"
  type = list(string)
  default = []
}

variable "public_subnet_ids" {
  description = "Public subnet ids"
  type = list(string)
  default = []
}

variable "public_alb_sg" {
  description = "Security groups associated with the public ALB"
  type = list(string)
  default = []
}

variable "internal_alb_sg" {
  description = "Security groups associated with the internal ALB"
  type = list(string)
  default = []
}
