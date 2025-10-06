variable "ecr_name" {
  type        = string
  description = "The name of the ECR repository"
}

variable "scan_on_push" {
  type        = bool
  default     = false
  description = "Enable scan on push"
}
