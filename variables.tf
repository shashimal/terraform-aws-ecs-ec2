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
    name          = string
    image         = string
    cpu           = number
    memory        = number
    containerPort = number
    hostPort      = number
    essential     = bool
  }))
}
