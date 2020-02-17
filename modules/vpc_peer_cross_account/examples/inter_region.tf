terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.31"
  region  = "us-west-2"
}

provider "aws" {
  version = "~> 2.31"
  region  = "us-east-1"
  alias   = "peer"
}

data "aws_caller_identity" "current" {
}

module "base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.12.0"

  cidr_range          = "172.18.0.0/16"
  custom_azs          = ["us-west-2a", "us-west-2b"]
  name                = "VPC-Peer-Origin"
  private_cidr_ranges = ["172.18.0.0/21", "172.18.8.0/21"]
  public_cidr_ranges  = ["172.18.168.0/22", "172.18.172.0/22"]
}

module "base_network_target" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.12.0"

  cidr_range          = "172.19.0.0/16"
  custom_azs          = ["us-east-1a", "us-east-1b"]
  private_cidr_ranges = ["172.19.0.0/21", "172.19.8.0/21"]
  public_cidr_ranges  = ["172.19.168.0/22", "172.19.172.0/22"]
  vpc_name            = "VPC-Peer-Target"

  providers = {
    aws = aws.peer
  }
}

module "cross_account_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.0.4"

  peer_cidr_range       = "172.19.0.0/16"
  peer_owner_id         = data.aws_caller_identity.current.account_id
  peer_region           = "us-east-1"
  peer_route_1_enable   = true
  peer_route_1_table_id = element(module.base_network_target.private_route_tables, 0)
  peer_route_2_enable   = true
  peer_route_2_table_id = element(module.base_network_target.private_route_tables, 1)
  peer_vpc_id           = module.base_network_target.vpc_id
  vpc_cidr_range        = "172.18.0.0/16"
  vpc_id                = module.base_network.vpc_id
  vpc_route_1_enable    = true
  vpc_route_1_table_id  = element(module.base_network.private_route_tables, 0)
  vpc_route_2_enable    = true
  vpc_route_2_table_id  = element(module.base_network.private_route_tables, 1)
}

