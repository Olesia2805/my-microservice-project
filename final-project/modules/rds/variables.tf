variable "use_aurora" {
  description = "Whether to create an Aurora cluster or a single RDS instance"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15.7"
}

variable "instance_class" {
  description = "Instance class for RDS instance"
  type        = string
  default     = "db.t3.medium"
}

variable "multi_az" {
  description = "Enable multi-AZ for RDS"
  type        = bool
  default     = false
}

variable "username" {
  description = "Master DB username"
  type        = string
  default     = "myapp_admin"
}

variable "password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where RDS will be deployed"
  type        = string
}

variable "allowed_cidr" {
  description = "CIDR allowed to connect to DB"
  type        = string
  default     = "0.0.0.0/0"
}

variable "db_parameter_overrides" {
  description = "Optional DB parameter overrides"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Base name for the DB resources"
  type        = string
  default     = "myapp"
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for encrypted storage"
  type        = string
  default     = null
}

variable "publicly_accessible" {
  description = "Should the DB be publicly accessible"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Primary database name"
  type        = string
  default     = "appdb"
}

variable "vpc_security_group_ids" {
  description = "List of security groups to attach to the RDS cluster"
  type        = list(string)
  default     = []
}

variable "security_group_ingress_from_sg_ids" {
  description = "List of security groups allowed to access RDS"
  type        = list(string)
  default     = []
}
