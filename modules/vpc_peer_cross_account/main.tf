/**
* # aws-terraform-vpc_peer/modules/vpc_peer_cross_account
*
* This module requires AWS Credentials for the peer account in the cross account case. The IAM user
* or IAM role must miminally have the below permissions to manage the entire lifecyle of the peering
* connection including route manipulation.  An example of the required [IAM Role](examples/cross_account_iam_setup.tf)
* can be used to create the required role.
*
* ```
* {
*    "Version": "2012-10-17",
*    "Statement": [
*        {
*            "Sid": "demo",
*            "Effect": "Allow",
*            "Action": [
*                "ec2:AcceptVpcPeeringConnection",
*                "ec2:CreateRoute",
*                "ec2:CreateTags",
*                "ec2:DeleteRoute",
*                "ec2:Describe*",
*                "ec2:ModifyVpcPeeringConnectionOptions",
*                "ec2:RejectVpcPeeringConnection"
*           ],
*           "Resource": "*"
*        }
*    ]
* }
* ```
*
* ## Basic Usage
*
* ```HCL
* module "cross_account_vpc_peer" {
*   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.12.2"
*
*   vpc_id = module.base_network.vpc_id
*
*   # VPC in acceptor account vpc-XXXXXXXXX
*   peer_vpc_id = module.peer_base_network.vpc_id
*
*   vpc_route_tables       = module.base_network.private_route_tables
*   vpc_route_tables_count = 2
*
*   # Acceptor Route Tables
*   peer_route_tables       = module.peer_base_network.private_route_tables
*   peer_route_tables_count = 2
*
*   providers = {
*     aws.peer = aws.peer
*   }
* }
* ```
*
* ### Cross account provider example
*
* ```HCL
* provider "aws" {
*   version = "~> 2.31"
*
*   alias  = "peer"
*   region = "us-west-2"
*
*   assume_role {
*     role_arn    = "arn:aws:iam::123456789012:role/AcceptVpcPeer"
*     external_id = "SomeExternalId"
*   }
* }
* ```
*
* ### Cross region provider example
*
* ```HCL
* provider "aws" {
*   alias  = "peer"
*   region = "us-east-1"
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
* ### Required provider
*
* The module now requires an explicitly defined AWS provider to be provided for the peer region and\or account.
* The examples have been updated to demonstrate passing in the provider.  As long as the peer information is
* not changed, no resources should be replaced as a result of this change.
*
* ### Module variables
*
* The following module variables were removed and are no longer neccessary:
*
* - `acceptor_access_key`
* - `acceptor_secret_key`
* - `peer_cidr_range`
* - `peer_owner_id`
* - `peer_region`
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

provider "aws" {
  alias = "peer"
}

data "aws_region" "peer" {
  provider = aws.peer
}

data "aws_caller_identity" "peer" {
  provider = aws.peer
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_vpc" "peer" {
  provider = aws.peer

  id = var.peer_vpc_id
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "vpc_peer" {
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = data.aws_region.peer.name
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider = aws.peer

  auto_accept               = true
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id

  tags = {
    Side = "Accepter"
  }
}

# As options can't be set until the connection has been accepted
# create an explicit dependency on the accepter.

resource "aws_vpc_peering_connection_options" "requester" {
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider = aws.peer

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

# VPC Route Tables

resource "aws_route" "vpc" {
  count = var.vpc_route_tables_count

  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  route_table_id            = element(var.vpc_route_tables, count.index)
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
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

  provider = aws.peer

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = element(var.peer_route_tables, count.index)
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_1" {
  count = var.peer_route_1_enable ? 1 : 0

  provider = aws.peer

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_1_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_2" {
  count = var.peer_route_2_enable ? 1 : 0

  provider = aws.peer

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_2_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_3" {
  count = var.peer_route_3_enable ? 1 : 0

  provider = aws.peer

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_3_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_4" {
  count = var.peer_route_4_enable ? 1 : 0

  provider = aws.peer

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_4_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_5" {
  count = var.peer_route_5_enable ? 1 : 0

  provider = aws.peer

  destination_cidr_block    = data.aws_vpc.vpc.cidr_block
  route_table_id            = var.peer_route_5_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

