variable "environment" {
  description = "Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test')"
  type        = "string"
  default     = "Development"
}

variable "tags" {
  description = "Custom tags to apply to all resources."
  type        = "map"
  default     = {}
}

variable "peer_owner_id" {
  description = "The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to. (OPTIONAL)"
  type        = "string"
  default     = ""
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection."
  type        = "string"
}

variable "vpc_id" {
  description = "The ID of the requester VPC."
  type        = "string"
}

variable "auto_accept" {
  description = "Accept the peering (both VPCs need to be in the same AWS account). (OPTIONAL)."
  type        = "string"
  default     = false
}

variable "peer_region" {
  description = "The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side. (OPTIONAL)"
  type        = "string"
  default     = ""
}

variable "allow_remote_vpc_dns_resolution" {
  description = "Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC."
  type        = "string"
  default     = true
}

variable "acceptor_access_key" {
  description = "An AWS Access Key with permissions to setup a VPC on the alternate account."
  type        = "string"
}

variable "acceptor_secret_key" {
  description = "An AWS Secret Key with permissions to setup a VPC on the alternate account."
  type        = "string"
}

#########################
#     VPC CIDR Range    #
#########################
variable "vpc_cidr_range" {
  description = "VPC CIDR Range e.g. 172.18.0.0/16"
  type        = "string"
  default     = "172.18.0.0/16"
}

#########################
#  VPC Peer CIDR Range  #
#########################
variable "peer_cidr_range" {
  description = "Peer VPC CIDR Range e.g. 172.19.0.0/16"
  type        = "string"
  default     = "172.19.0.0/16"
}

#########################
#   VPC Route Table 1   #
#########################

variable "vpc_route_1_enable" {
  description = "Enables VPC Route Table 1. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "vpc_route_1_table_id" {
  description = "ID of VPC Route table #1 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#   VPC Route Table 2   #
#########################
variable "vpc_route_2_enable" {
  description = "Enables VPC Route Table 2. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "vpc_route_2_table_id" {
  description = "ID of VPC Route table #2 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#   VPC Route Table 3   #
#########################
variable "vpc_route_3_enable" {
  description = "Enables VPC Route Table 3. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "vpc_route_3_table_id" {
  description = "ID of VPC Route table #3 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#   VPC Route Table 4   #
#########################
variable "vpc_route_4_enable" {
  description = "Enables VPC Route Table 4. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "vpc_route_4_table_id" {
  description = "ID of VPC Route table #4 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#   VPC Route Table 5   #
#########################
variable "vpc_route_5_enable" {
  description = "Enables VPC Route Table 5. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "vpc_route_5_table_id" {
  description = "ID of VPC Route table #5 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#  Peer Route Table 1   #
#########################
variable "peer_route_1_enable" {
  description = "Enables Peer Route Table 1. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "peer_route_1_table_id" {
  description = "ID of VPC Route table #1 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#  Peer Route Table 2   #
#########################
variable "peer_route_2_enable" {
  description = "Enables Peer Route Table 2. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "peer_route_2_table_id" {
  description = "ID of VPC Route table #2 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#  Peer Route Table 3   #
#########################
variable "peer_route_3_enable" {
  description = "Enables Peer Route Table 3. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "peer_route_3_table_id" {
  description = "ID of VPC Route table #3 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#  Peer Route Table 4   #
#########################
variable "peer_route_4_enable" {
  description = "Enables Peer Route Table 4. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "peer_route_4_table_id" {
  description = "ID of VPC Route table #4 rtb-XXXXXX"
  type        = "string"
  default     = ""
}

#########################
#  Peer Route Table 5   #
#########################
variable "peer_route_5_enable" {
  description = "Enables Peer Route Table 5. Allowed values: true, false"
  type        = "string"
  default     = false
}

variable "peer_route_5_table_id" {
  description = "ID of VPC Route table #5 rtb-XXXXXX"
  type        = "string"
  default     = ""
}
