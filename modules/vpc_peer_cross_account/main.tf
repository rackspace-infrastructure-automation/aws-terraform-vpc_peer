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
resource "aws_vpc_peering_connection" "peer" {
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
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
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
