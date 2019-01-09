provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

provider "aws" {
  version = "~> 1.2"
  region  = "us-east-2"
  alias   = "ohio"
}

module "base_network" {
  source              = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=master"
  vpc_name            = "VPC-Peer-Origin"
  cidr_range          = "172.18.0.0/16"
  public_cidr_ranges  = ["172.18.168.0/22", "172.18.172.0/22"]
  private_cidr_ranges = ["172.18.0.0/21", "172.18.8.0/21"]
}

module "peer_base_network" {
  source              = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=master"
  vpc_name            = "VPC-Peer-Accepter"
  cidr_range          = "10.0.0.0/16"
  public_cidr_ranges  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_cidr_ranges = ["10.0.2.0/24", "10.0.4.0/24"]
}

module "remote_peer_base_network" {
  source              = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=master"
  vpc_name            = "Remote-VPC-Peer-Accepter"
  cidr_range          = "192.168.0.0/16"
  public_cidr_ranges  = ["192.168.168.0/22", "192.168.172.0/22"]
  private_cidr_ranges = ["192.168.0.0/21", "192.168.8.0/21"]

  providers = {
    aws = "aws.ohio"
  }
}

module "vpc_peer" {
  source                          = "../../module/modules/vpc_peer"
  vpc_id                          = "${module.base_network.vpc_id}"
  peer_vpc_id                     = "${module.peer_base_network.vpc_id}"
  auto_accept                     = true
  allow_remote_vpc_dns_resolution = true
}

data "aws_caller_identity" "current" {}

module "cross_account_vpc_peer" {
  source = "../../module/modules/vpc_peer_cross_account"

  vpc_id          = "${module.base_network.vpc_id}"
  is_inter_region = true
  peer_vpc_id     = "${module.remote_peer_base_network.vpc_id}"
  peer_owner_id   = "${data.aws_caller_identity.current.account_id}"
  peer_region     = "us-east-2"

  auto_accept         = true
  acceptor_access_key = ""
  acceptor_secret_key = ""

  vpc_cidr_range  = "172.18.0.0/16"
  peer_cidr_range = "192.168.0.0/16"

  vpc_route_1_enable   = true
  vpc_route_1_table_id = "${element(module.base_network.private_route_tables, 0)}"
  vpc_route_2_enable   = true
  vpc_route_2_table_id = "${element(module.base_network.private_route_tables, 1)}"

  peer_route_1_enable   = true
  peer_route_1_table_id = "${element(module.remote_peer_base_network.private_route_tables, 0)}"
  peer_route_2_enable   = true
  peer_route_2_table_id = "${element(module.remote_peer_base_network.private_route_tables, 1)}"
}
