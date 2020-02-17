/**
* # aws-terraform-vpc_peer/modules/vpc_peer
*
* The module sets up a VPC peer in a single region and AWS Account. For inter region
* and cross account VPC peering see the companion [cross account module ](../vpc_peer_cross_account)
*
* ## Basic Usage
*
* ```
* module "vpc_peer" {
*  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer?ref=v0.12.0"
*
*  vpc_id                          = module.base_network.vpc_id
*  peer_vpc_id                     = module.peer_base_network.vpc_id
*  auto_accept                     = true
*  allow_remote_vpc_dns_resolution = true
*  vpc_cidr_range                  = "172.18.0.0/16"
*  peer_cidr_range                 = "10.0.0.0/16"
*
*  #  VPC Routes
*  vpc_route_1_enable   = true
*  vpc_route_1_table_id = element(module.base_network.private_route_tables, 0)
*  vpc_route_2_enable   = true
*  vpc_route_2_table_id = element(module.base_network.private_route_tables, 1)
*
*  # Peer Routes
*  peer_route_1_enable   = true
*  peer_route_1_table_id = element(module.peer_base_network.private_route_tables, 0)
*  peer_route_2_enable   = true
*  peer_route_2_table_id = element(module.peer_base_network.private_route_tables, 1)
* }
* ```
*
* Full working references are available at [examples](examples)
*
*/

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.31.0"
  }
}

locals {
  tags = {
    Environment     = var.environment
    ServiceProvider = "Rackspace"
  }
}

resource "aws_vpc_peering_connection" "vpc_peer" {
  auto_accept = var.auto_accept
  peer_vpc_id = var.peer_vpc_id
  tags        = merge(var.tags, local.tags)
  vpc_id      = var.vpc_id

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }

  requester {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}

# VPC Route Tables
resource "aws_route" "vpc_route_1" {
  count = var.vpc_route_1_enable ? 1 : 0

  destination_cidr_block    = var.peer_cidr_range
  route_table_id            = var.vpc_route_1_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_2" {
  count = var.vpc_route_2_enable ? 1 : 0

  destination_cidr_block    = var.peer_cidr_range
  route_table_id            = var.vpc_route_2_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_3" {
  count = var.vpc_route_3_enable ? 1 : 0

  destination_cidr_block    = var.peer_cidr_range
  route_table_id            = var.vpc_route_3_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_4" {
  count = var.vpc_route_4_enable ? 1 : 0

  destination_cidr_block    = var.peer_cidr_range
  route_table_id            = var.vpc_route_4_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_5" {
  count = var.vpc_route_5_enable ? 1 : 0

  destination_cidr_block    = var.peer_cidr_range
  route_table_id            = var.vpc_route_5_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

# Peer VPC Route Tables
resource "aws_route" "peer_route_1" {
  count = var.peer_route_1_enable ? 1 : 0

  destination_cidr_block    = var.vpc_cidr_range
  route_table_id            = var.peer_route_1_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_2" {
  count = var.peer_route_2_enable ? 1 : 0

  destination_cidr_block    = var.vpc_cidr_range
  route_table_id            = var.peer_route_2_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_3" {
  count = var.peer_route_3_enable ? 1 : 0

  destination_cidr_block    = var.vpc_cidr_range
  route_table_id            = var.peer_route_3_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_4" {
  count = var.peer_route_4_enable ? 1 : 0

  destination_cidr_block    = var.vpc_cidr_range
  route_table_id            = var.peer_route_4_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_5" {
  count = var.peer_route_5_enable ? 1 : 0

  destination_cidr_block    = var.vpc_cidr_range
  route_table_id            = var.peer_route_5_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

