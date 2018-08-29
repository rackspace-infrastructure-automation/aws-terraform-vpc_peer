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
  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
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
