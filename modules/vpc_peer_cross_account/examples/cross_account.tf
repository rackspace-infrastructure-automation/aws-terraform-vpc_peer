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
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer?ref=v0.0.1"
  vpc_id = "${module.base_network.vpc_id}"

  # VPC in acceptor account vpc-XXXXXXXXX
  peer_vpc_id = "vpc-XXXXXXXX"

  # Acceptor account number
  peer_owner_id = "XXXXXXXXXXXX"

  # Acceptor VPC Region
  peer_region = "us-west-2"

  # Acceptor Secret Key. Use a local secrets.tf file
  acceptor_access_key = "${var.acceptor_access_key}"
  acceptor_secret_key = "${var.acceptor_secret_key}"
}
