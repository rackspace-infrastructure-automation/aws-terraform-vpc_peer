provider "aws" {
  version = "~> 2.31"
  region  = "us-west-2"
}

provider "aws" {
  version = "~> 2.31"
  region  = "us-east-1"
  alias   = "peer"
}

data "aws_caller_identity" "current" {}

module "base_network" {
  source              = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.0.10"
  vpc_name            = "VPC-Peer-Origin"
  cidr_range          = "172.18.0.0/16"
  public_cidr_ranges  = ["172.18.168.0/22", "172.18.172.0/22"]
  private_cidr_ranges = ["172.18.0.0/21", "172.18.8.0/21"]
  custom_azs          = ["us-west-2a", "us-west-2b"]
}

module "base_network_target" {
  source              = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.0.10"
  vpc_name            = "VPC-Peer-Target"
  cidr_range          = "172.19.0.0/16"
  public_cidr_ranges  = ["172.19.168.0/22", "172.19.172.0/22"]
  private_cidr_ranges = ["172.19.0.0/21", "172.19.8.0/21"]
  custom_azs          = ["us-east-1a", "us-east-1b"]

  providers = {
    aws = "aws.peer"
  }
}

module "cross_account_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.0.4"

  vpc_id = "${module.base_network.vpc_id}"

  # VPC in acceptor account vpc-XXXXXXXXX
  peer_vpc_id = "${module.base_network_target.vpc_id}"

  # Acceptor account number
  peer_owner_id = "${data.aws_caller_identity.current.account_id}"

  # Acceptor VPC Region
  peer_region = "us-east-1"

  vpc_cidr_range = "172.18.0.0/16"

  # Acceptor cidr Range e.g. 172.19.0.0/16
  peer_cidr_range = "172.19.0.0/16"

  vpc_route_1_enable   = true
  vpc_route_1_table_id = "${element(module.base_network.private_route_tables, 0)}"
  vpc_route_2_enable   = true
  vpc_route_2_table_id = "${element(module.base_network.private_route_tables, 1)}"

  # Acceptor Route Tables
  # Acceptor Route Table ID rtb-XXXXXXX
  peer_route_1_enable = true

  peer_route_1_table_id = "${element(module.base_network_target.private_route_tables, 0)}"
  peer_route_2_enable   = true
  peer_route_2_table_id = "${element(module.base_network_target.private_route_tables, 1)}"
}
