/**
* # aws-terraform-vpc_peer/modules/vpc_peer_cross_account
*
*This module requires AWS Credentials for the Acceptor account.
*
*To use the `cross_account.tf` or `inter_region.tf` examples, create a file called `secrets.tf` in the `example` folder, and populate it with the following, replacing the X's with the Acceptor's account credentials.
*
***NOTE:** To create an inter-region peering connection, specify the origin AWS account number as the value for the `peer_owner_id` parameter. You must also set the `is_inter_region` parameter to `true` in order to prevent the module from attempting to set unsupported peering connection options.
*
*## Basic Usage
*
*```
*module "cross_account_vpc_peer" {
*  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.0.2"
*  vpc_id = "${module.base_network.vpc_id}"
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
*  # Acceptor Secret Key. Use a local secrets.tf file
*  acceptor_access_key = "${var.acceptor_access_key}"
*  acceptor_secret_key = "${var.acceptor_secret_key}"
*
*  vpc_cidr_range = "172.18.0.0/16"
*
*  # Acceptor cidr Range e.g. 172.19.0.0/16
*  peer_cidr_range = "X.X.X.X/16"
*
*  vpc_route_1_enable   = true
*  vpc_route_1_table_id = "${element(module.base_network.private_route_tables, 0)}"
*  vpc_route_2_enable   = true
*  vpc_route_2_table_id = "${element(module.base_network.private_route_tables, 1)}"
*
*  # Acceptor Route Tables
*  # Acceptor Route Table ID rtb-XXXXXXX
*  peer_route_1_enable = true
*
*  peer_route_1_table_id = "rtb-XXXXX"
*  peer_route_2_enable   = true
*  peer_route_2_table_id = "rtb-XXXXX"
*}
*```
*
* Full working references are available at [examples](examples)
*
*/

locals {
  tags {
    ServiceProvider = "Rackspace"
    Environment     = "${var.environment}"
  }
}

provider "aws" {
  alias  = "peer"
  region = "${var.peer_region}"

  # Accepter's credentials.
  access_key = "${var.acceptor_access_key}"
  secret_key = "${var.acceptor_secret_key}"
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "vpc_peer" {
  vpc_id        = "${var.vpc_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  peer_owner_id = "${var.peer_owner_id}"
  auto_accept   = false
  peer_region   = "${var.peer_region}"

  tags {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
  auto_accept               = true

  tags {
    Side = "Accepter"
  }
}

# As options can't be set until the connection has been accepted
# create an explicit dependency on the accepter.

resource "aws_vpc_peering_connection_options" "requester" {
  count                     = "${var.is_inter_region ? 0 : 1}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  count                     = "${var.is_inter_region ? 0 : 1}"
  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

# VPC Route Tables
resource "aws_route" "vpc_route_1" {
  count                     = "${var.vpc_route_1_enable ? 1 : 0}"
  route_table_id            = "${var.vpc_route_1_table_id}"
  destination_cidr_block    = "${var.peer_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "vpc_route_2" {
  count                     = "${var.vpc_route_2_enable ? 1 : 0}"
  route_table_id            = "${var.vpc_route_2_table_id}"
  destination_cidr_block    = "${var.peer_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "vpc_route_3" {
  count                     = "${var.vpc_route_3_enable ? 1 : 0}"
  route_table_id            = "${var.vpc_route_3_table_id}"
  destination_cidr_block    = "${var.peer_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "vpc_route_4" {
  count                     = "${var.vpc_route_4_enable ? 1 : 0}"
  route_table_id            = "${var.vpc_route_4_table_id}"
  destination_cidr_block    = "${var.peer_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "vpc_route_5" {
  count                     = "${var.vpc_route_5_enable ? 1 : 0}"
  route_table_id            = "${var.vpc_route_5_table_id}"
  destination_cidr_block    = "${var.peer_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

# Peer VPC Route Tables
resource "aws_route" "peer_route_1" {
  provider                  = "aws.peer"
  count                     = "${var.peer_route_1_enable ? 1 : 0}"
  route_table_id            = "${var.peer_route_1_table_id}"
  destination_cidr_block    = "${var.vpc_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "peer_route_2" {
  provider                  = "aws.peer"
  count                     = "${var.peer_route_2_enable ? 1 : 0}"
  route_table_id            = "${var.peer_route_2_table_id}"
  destination_cidr_block    = "${var.vpc_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "peer_route_3" {
  provider                  = "aws.peer"
  count                     = "${var.peer_route_3_enable ? 1 : 0}"
  route_table_id            = "${var.peer_route_3_table_id}"
  destination_cidr_block    = "${var.vpc_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "peer_route_4" {
  provider                  = "aws.peer"
  count                     = "${var.peer_route_4_enable ? 1 : 0}"
  route_table_id            = "${var.peer_route_4_table_id}"
  destination_cidr_block    = "${var.vpc_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

resource "aws_route" "peer_route_5" {
  provider                  = "aws.peer"
  count                     = "${var.peer_route_5_enable ? 1 : 0}"
  route_table_id            = "${var.peer_route_5_table_id}"
  destination_cidr_block    = "${var.vpc_cidr_range}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}
