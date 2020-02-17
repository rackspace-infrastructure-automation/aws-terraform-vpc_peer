/**
* # aws-terraform-vpc_peer/modules/vpc_peer_cross_account
*
* This module requires AWS Credentials for the Acceptor account in the cross account case. The IAM user must miminally have the below permissions to manage the entire lifecyle of the peering connection including route manipulation.
*
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
*                "ec2:DescribeRouteTables",
*                "ec2:DescribeTags",
*                "ec2:DescribeVpcPeeringConnections",
*                "ec2:ModifyVpcPeeringConnectionOptions",
*                "ec2:RejectVpcPeeringConnection"
*           ],
*           "Resource": "*"
*        }
*    ]
* }
* ```
*
* **NOTE 1:** To use the `cross_account.tf` example create a file called `secrets.tf` similar to the `secrets.tf.example` file in the `examples` folder.
*
* **NOTE 2:** To create an inter-region peering connection, specify the origin AWS account number as the value for the `peer_owner_id` parameter.
*
* ## Basic Usage
*
* ```
* module "cross_account_vpc_peer" {
*  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.12.0"
*
*  vpc_id = module.base_network.vpc_id
*
*  # VPC in acceptor account vpc-XXXXXXXXX
*  peer_vpc_id = "vpc-XXXXXXXXX"
*
*  # Acceptor account number
*  peer_owner_id = "XXXXXXXXXXXXX"
*
*  # Acceptor VPC Region
*  peer_region = "us-west-2"
*
*  # Acceptor Access and Secret Key.
*  # These are added inline for clarity but should never be commited directly to the terraform config as seen here.
*  # Use a local secrets.tf as seen in example directory
*  acceptor_access_key = "ACCESS_KEY_HERE"
*  acceptor_secret_key = "SECRET_KEY_HERE"
*
*  vpc_cidr_range = "172.18.0.0/16"
*
*  # Acceptor cidr Range e.g. 172.19.0.0/16
*  peer_cidr_range = "X.X.X.X/16"
*
*  vpc_route_1_enable   = true
*  vpc_route_1_table_id = element(module.base_network.private_route_tables, 0)
*  vpc_route_2_enable   = true
*  vpc_route_2_table_id = element(module.base_network.private_route_tables, 1)
*
*  # Acceptor Route Tables
*  # Acceptor Route Table ID rtb-XXXXXXX
*  peer_route_1_enable = true
*
*  peer_route_1_table_id = "rtb-XXXXX"
*  peer_route_2_enable   = true
*  peer_route_2_table_id = "rtb-XXXXX"
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
    ServiceProvider = "Rackspace"
    Environment     = var.environment
  }
}

provider "aws" {
  alias  = "peer"
  region = var.peer_region

  # Accepter's credentials.
  access_key = var.acceptor_access_key
  secret_key = var.acceptor_secret_key
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "vpc_peer" {
  vpc_id        = var.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = var.peer_owner_id
  peer_region   = var.peer_region

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
  auto_accept               = true

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
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

# VPC Route Tables
resource "aws_route" "vpc_route_1" {
  count                     = var.vpc_route_1_enable ? 1 : 0
  route_table_id            = var.vpc_route_1_table_id
  destination_cidr_block    = var.peer_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_2" {
  count                     = var.vpc_route_2_enable ? 1 : 0
  route_table_id            = var.vpc_route_2_table_id
  destination_cidr_block    = var.peer_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_3" {
  count                     = var.vpc_route_3_enable ? 1 : 0
  route_table_id            = var.vpc_route_3_table_id
  destination_cidr_block    = var.peer_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_4" {
  count                     = var.vpc_route_4_enable ? 1 : 0
  route_table_id            = var.vpc_route_4_table_id
  destination_cidr_block    = var.peer_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "vpc_route_5" {
  count                     = var.vpc_route_5_enable ? 1 : 0
  route_table_id            = var.vpc_route_5_table_id
  destination_cidr_block    = var.peer_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

# Peer VPC Route Tables
resource "aws_route" "peer_route_1" {
  provider                  = aws.peer
  count                     = var.peer_route_1_enable ? 1 : 0
  route_table_id            = var.peer_route_1_table_id
  destination_cidr_block    = var.vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_2" {
  provider                  = aws.peer
  count                     = var.peer_route_2_enable ? 1 : 0
  route_table_id            = var.peer_route_2_table_id
  destination_cidr_block    = var.vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_3" {
  provider                  = aws.peer
  count                     = var.peer_route_3_enable ? 1 : 0
  route_table_id            = var.peer_route_3_table_id
  destination_cidr_block    = var.vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_4" {
  provider                  = aws.peer
  count                     = var.peer_route_4_enable ? 1 : 0
  route_table_id            = var.peer_route_4_table_id
  destination_cidr_block    = var.vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "peer_route_5" {
  provider                  = aws.peer
  count                     = var.peer_route_5_enable ? 1 : 0
  route_table_id            = var.peer_route_5_table_id
  destination_cidr_block    = var.vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

