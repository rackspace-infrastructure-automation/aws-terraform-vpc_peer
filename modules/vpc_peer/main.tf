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
*  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer?ref=v0.12.2"
*
*  vpc_id                          = module.base_network.vpc_id
*  peer_vpc_id                     = module.peer_base_network.vpc_id
*  auto_accept                     = true
*  allow_remote_vpc_dns_resolution = true
*
*  #  VPC Routes
*  vpc_route_tables       = module.base_network.private_route_tables
*  vpc_route_tables_count = 2
*
*  # Peer Routes
*  peer_route_tables       = module.peer_base_network.private_route_tables
*  peer_route_tables_count = 2
* }
* ```
*
* Full working references are available at [examples](examples)
*
* ## Terraform 0.12 upgrade
*
* Several changes were required while adding terraform 0.12 compatibility.  The following changes should be
* made when upgrading from a previous release to version 0.12.0 or higher.
*
* ### Module variables
*
* The following module variables were removed and are no longer neccessary:
*
* - `peer_cidr_range`
* - `vpc_cidr_range`
*
* New variables `peer_route_tables` and `peer_route_tables_count` were added to replace the functionality of the various `peer_route_x_enable` and `peer_route_x_table_id` variables.  These deprecated variables and resources will continue to work as expected, but will be removed in a future release.
*
* New variables `vpc_route_tables` and `vpc_route_tables_count` were added to replace the functionality of the various `vpc_route_x_enable` and `vpc_route_x_table_id` variables.  These deprecated variables and resources will continue to work as expected, but will be removed in a future release.
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

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_vpc" "peer" {
  id = var.peer_vpc_id
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
resource "aws_route" "vpc" {
  count = var.vpc_route_tables_count

  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  route_table_id            = element(var.vpc_route_tables, count.index)
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id

  depends_on = [
    aws_route.vpc_route_1,
    aws_route.vpc_route_2,
    aws_route.vpc_route_3,
    aws_route.vpc_route_4,
    aws_route.vpc_route_5,
  ]
}

resource "aws_route" "vpc_route_1" {
  count = var.vpc_route_1_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  route_table_id            = var.vpc_route_1_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_2" {
  count = var.vpc_route_2_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  route_table_id            = var.vpc_route_2_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_3" {
  count = var.vpc_route_3_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  route_table_id            = var.vpc_route_3_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_4" {
  count = var.vpc_route_4_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  route_table_id            = var.vpc_route_4_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_5" {
  count = var.vpc_route_5_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  route_table_id            = var.vpc_route_5_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

# Peer VPC Route Tables
resource "aws_route" "peer" {
  count = var.peer_route_tables_count

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = element(var.peer_route_tables, count.index)
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id

  depends_on = [
    aws_route.peer_route_1,
    aws_route.peer_route_2,
    aws_route.peer_route_3,
    aws_route.peer_route_4,
    aws_route.peer_route_5,
  ]
}

resource "aws_route" "peer_route_1" {
  count = var.peer_route_1_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_1_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_2" {
  count = var.peer_route_2_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_2_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_3" {
  count = var.peer_route_3_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_3_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_4" {
  count = var.peer_route_4_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_4_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_5" {
  count = var.peer_route_5_enable ? 1 : 0

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_5_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

