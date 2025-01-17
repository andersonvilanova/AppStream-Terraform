variable "region" {
  description = "Region that the VPC will be created"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC that will be created"
  type        = string
  default     = "vpc_terraform"
}

variable "vpc_cidr" {
  description = "CIDR of the VPC that will be created"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_private_a_cidr" {
  description = "CIDR of the private subnet on availability zone A that will be created"
  type        = string
  default     = "10.10.1.0/24"
}

variable "subnet_private_b_cidr" {
  description = "CIDR of the private subnet on availability zone B that will be created"
  type        = string
  default     = "10.10.2.0/24"
}

variable "subnet_public_a_cidr" {
  description = "CIDR of the public subnet on availability zone A that will be created"
  type        = string
  default     = "10.10.11.0/24"
}

variable "subnet_public_b_cidr" {
  description = "CIDR of the public subnet on availability zone B that will be created"
  type        = string
  default     = "10.10.12.0/24"
}

variable "internet_gateway_name" {
  description = "Description to Internet Gateway that will be created"
  type        = string
  default     = "_igw"
}

variable "dns" {
  description = "DNS servers that will be created on new dhcp options"
  type        = string
  default     = "10.10.10.10, 10.10.10.20"
}

variable "domain_name" {
  description = "Domain name that will be created on new dhcp options"
  type        = string
  default     = "appstream.lab"
}

variable "appstream_name" {
  description = "AppStream fleet name"
  type        = string
  default     = "appstream_lab"
}

variable "appstream_image" {
  description = "AppStream image name to be added to fleet"
  type        = string
  default     = "Amazon-AppStream2-Sample-Image-06-17-2024"
}

variable "appstream_instace_type" {
  description = "AppStream image name to be added to fleet"
  type        = string
  default     = "stream.standard.medium"
}

variable "stack_name" {
  description = "AppStream stack name"
  type        = string
  default     = "stack_lab"
}