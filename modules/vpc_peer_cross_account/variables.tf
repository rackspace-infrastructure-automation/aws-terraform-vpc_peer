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

variable "peer_route_tables" {
  description = "A list of all peer route tables IDs"
  type        = list(string)
  default     = []
}

variable "peer_route_tables_count" {
  description = "The number of peer route tables"
  type        = number
  default     = 0
}

variable "peer_route_1_enable" {
  description = "Enables Peer Route Table 1. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "peer_route_1_table_id" {
  description = "ID of VPC Route table #1 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "peer_route_2_enable" {
  description = "Enables Peer Route Table 2. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "peer_route_2_table_id" {
  description = "ID of VPC Route table #2 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "peer_route_3_enable" {
  description = "Enables Peer Route Table 3. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "peer_route_3_table_id" {
  description = "ID of VPC Route table #3 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "peer_route_4_enable" {
  description = "Enables Peer Route Table 4. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "peer_route_4_table_id" {
  description = "ID of VPC Route table #4 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "peer_route_5_enable" {
  description = "Enables Peer Route Table 5. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "peer_route_5_table_id" {
  description = "ID of VPC Route table #5 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables."
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

variable "vpc_route_tables" {
  description = "A list of all VPC route tables IDs"
  type        = list(string)
  default     = []
}

variable "vpc_route_tables_count" {
  description = "The number of VPC route tables"
  type        = number
  default     = 0
}

variable "vpc_route_1_enable" {
  description = "Enables VPC Route Table 1. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "vpc_route_1_table_id" {
  description = "ID of VPC Route table #1 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "vpc_route_2_enable" {
  description = "Enables VPC Route Table 2. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "vpc_route_2_table_id" {
  description = "ID of VPC Route table #2 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "vpc_route_3_enable" {
  description = "Enables VPC Route Table 3. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "vpc_route_3_table_id" {
  description = "ID of VPC Route table #3 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "vpc_route_4_enable" {
  description = "Enables VPC Route Table 4. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "vpc_route_4_table_id" {
  description = "ID of VPC Route table #4 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = string
  default     = ""
}

variable "vpc_route_5_enable" {
  description = "Enables VPC Route Table 5. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = bool
  default     = false
}

variable "vpc_route_5_table_id" {
  description = "ID of VPC Route table #5 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables."
  type        = string
  default     = ""
}
