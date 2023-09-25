variable "region" {
  description = "AWS region to deploy"
  default     = "eu-central-1"
}

variable "access_key" {
  description = "AWS access_key"
  default     = "AKI**************4TZB"
}

variable "secret_key" {
  description = "AWS secret_key"
  default     = "6908*************************q1GRN"
}

variable "vpc_cdir_block" {
  description = "Main CDIR block for VPC"
  default     = "10.121.0.0/16"
}

variable "public_subnets" {
  description = "public_subnet"
  default     = ["10.121.1.0/24"]
}

variable "private_subnets" {
  description = "private_subnet"
  default     = ["10.121.121.0/24"]
}

variable "private_ips_by_name" {
  type = map(any)
  default = {
    "prometheus" = ["10.121.121.10"]
  }
}

variable "project" {
  default = "richads"
}

variable "namespace" {
  default = "cs"
}

variable "environment" {
  default = "Dev"
}

variable "env" {
  default = "dev"
}

variable "env-index" {
  default = "1"
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Project = "rich"
  }
}

variable "availability_zones" {
  description = "availability_zones"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "ssh_key_private" {
  default     = "~/.ssh/richads"
  description = "Path to the SSH public key for accessing cloud instances. Used for creating AWS keypair."
}
