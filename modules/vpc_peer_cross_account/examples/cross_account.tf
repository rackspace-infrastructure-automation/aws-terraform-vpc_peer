provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "base_network" {
  source              = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.0.1"
  vpc_name            = "VPC-Peer-Origin"
  cidr_range          = "172.18.0.0/16"
  public_cidr_ranges  = ["172.18.168.0/22", "172.18.172.0/22"]
  private_cidr_ranges = ["172.18.0.0/21", "172.18.8.0/21"]
}

module "cross_account_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.0.1"
  vpc_id = "${module.base_network.vpc_id}"

  # VPC in acceptor account vpc-XXXXXXXXX
  peer_vpc_id = "vpc-XXXXXXXXX"

  # Acceptor account number
  peer_owner_id = "XXXXXXXXXXXXX"

  # Acceptor VPC Region
  peer_region = "us-west-2"

  # Acceptor Secret Key. Use a local secrets.tf file
  acceptor_access_key = "${var.acceptor_access_key}"
  acceptor_secret_key = "${var.acceptor_secret_key}"

  vpc_cidr_range = "172.18.0.0/16"

  # Acceptor cidr Range e.g. 172.19.0.0/16
  peer_cidr_range = "X.X.X.X/16"

  vpc_route_1_enable   = true
  vpc_route_1_table_id = "${element(module.base_network.private_route_tables, 0)}"
  vpc_route_2_enable   = true
  vpc_route_2_table_id = "${element(module.base_network.private_route_tables, 1)}"

  # Acceptor Route Tables
  # Acceptor Route Table ID rtb-XXXXXXX
  peer_route_1_enable = true

  peer_route_1_table_id = "rtb-XXXXX"
  peer_route_2_enable   = true
  peer_route_2_table_id = "rtb-XXXXX"
}
