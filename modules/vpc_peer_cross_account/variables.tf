variable "allow_remote_vpc_dns_resolution" {
  description = "Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC."
  type        = bool
  default     = true
}

variable "environment" {
  description = "Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test')"
  type        = string
  default     = "Development"
}

variable "peer_route_1_enable" {
  description = "Enables Peer Route Table 1. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "peer_route_1_table_id" {
  description = "ID of VPC Route table #1 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "peer_route_2_enable" {
  description = "Enables Peer Route Table 2. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "peer_route_2_table_id" {
  description = "ID of VPC Route table #2 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "peer_route_3_enable" {
  description = "Enables Peer Route Table 3. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "peer_route_3_table_id" {
  description = "ID of VPC Route table #3 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "peer_route_4_enable" {
  description = "Enables Peer Route Table 4. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "peer_route_4_table_id" {
  description = "ID of VPC Route table #4 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "peer_route_5_enable" {
  description = "Enables Peer Route Table 5. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "peer_route_5_table_id" {
  description = "ID of VPC Route table #5 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection."
  type        = string
}

variable "tags" {
  description = "Custom tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "vpc_route_1_enable" {
  description = "Enables VPC Route Table 1. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "vpc_route_1_table_id" {
  description = "ID of VPC Route table #1 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "vpc_route_2_enable" {
  description = "Enables VPC Route Table 2. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "vpc_route_2_table_id" {
  description = "ID of VPC Route table #2 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "vpc_route_3_enable" {
  description = "Enables VPC Route Table 3. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "vpc_route_3_table_id" {
  description = "ID of VPC Route table #3 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "vpc_route_4_enable" {
  description = "Enables VPC Route Table 4. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "vpc_route_4_table_id" {
  description = "ID of VPC Route table #4 rtb-XXXXXX"
  type        = string
  default     = ""
}

variable "vpc_route_5_enable" {
  description = "Enables VPC Route Table 5. Allowed values: true, false"
  type        = bool
  default     = false
}

variable "vpc_route_5_table_id" {
  description = "ID of VPC Route table #5 rtb-XXXXXX"
  type        = string
  default     = ""
}
