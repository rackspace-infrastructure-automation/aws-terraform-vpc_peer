locals {
  tags {
    ServiceProvider = "Rackspace"
    Environment     = "${var.environment}"
  }
}

resource "aws_vpc_peering_connection" "vpc_peer" {
  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  vpc_id        = "${var.vpc_id}"
  auto_accept   = "${var.auto_accept}"
  peer_region   = "${var.peer_region}"

  accepter {
    allow_remote_vpc_dns_resolution = "${var.allow_remote_vpc_dns_resolution}"
  }

  requester {
    allow_remote_vpc_dns_resolution = "${var.allow_remote_vpc_dns_resolution}"
  }

  tags = "${merge(var.tags, local.tags)}"
}
