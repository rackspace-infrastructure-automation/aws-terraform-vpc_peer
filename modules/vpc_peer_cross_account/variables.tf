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
