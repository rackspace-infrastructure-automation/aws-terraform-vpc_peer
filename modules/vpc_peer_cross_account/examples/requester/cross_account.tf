terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
  alias   = "peer"

  assume_role {
    role_arn    = "cross_account_role_arn output"
    external_id = "external_id output"
  }
}

module "base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.12.4"

  cidr_range          = "172.19.0.0/16"
  name                = "VPC-Peer-Origin"
  private_cidr_ranges = ["172.19.0.0/21", "172.19.8.0/21"]
  public_cidr_ranges  = ["172.19.168.0/22", "172.19.172.0/22"]
}

module "cross_account_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.3"

  peer_route_tables       = ["route_tables output"]
  peer_route_tables_count = 1
  peer_vpc_id             = "acceptor_vpc_id output"
  vpc_id                  = module.base_network.vpc_id
  vpc_route_tables        = module.base_network.private_route_tables
  vpc_route_tables_count  = 1

  providers = {
    aws.peer = aws.peer
  }
}

