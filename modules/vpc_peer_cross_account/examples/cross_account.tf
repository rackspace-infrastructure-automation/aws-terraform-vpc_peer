terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.31"
  region  = "us-west-2"
}

provider "aws" {
  version = "~> 2.31"

  alias  = "peer"
  region = "us-west-2"

  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/AcceptVpcPeer"
    external_id = "SomeExternalId"
  }
}

module "base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.12.4"

  cidr_range          = "172.18.0.0/16"
  name                = "VPC-Peer-Origin"
  private_cidr_ranges = ["172.18.0.0/21", "172.18.8.0/21"]
  public_cidr_ranges  = ["172.18.168.0/22", "172.18.172.0/22"]
}

module "cross_account_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.12.2"

  peer_route_tables       = ["rtb-xxxxxxxx", "rtb-yyyyyyyy"]
  peer_route_tables_count = 2
  peer_vpc_id             = "vpc-XXXXXXXXX"
  vpc_id                  = module.base_network.vpc_id
  vpc_route_tables        = module.base_network.private_route_tables
  vpc_route_tables_count  = 2

  providers = {
    aws = aws.peer
  }
}

