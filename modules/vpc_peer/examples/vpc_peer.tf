terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.31"
  region  = "us-west-2"
}

module "base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.12.0"

  cidr_range          = "172.18.0.0/16"
  name                = "VPC-Peer-Origin"
  private_cidr_ranges = ["172.18.0.0/21", "172.18.8.0/21"]
  public_cidr_ranges  = ["172.18.168.0/22", "172.18.172.0/22"]
}

module "peer_base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.12.0"

  cidr_range          = "10.0.0.0/16"
  name                = "VPC-Peer-Accepter"
  private_cidr_ranges = ["10.0.2.0/24", "10.0.4.0/24"]
  public_cidr_ranges  = ["10.0.1.0/24", "10.0.3.0/24"]
}

module "vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer?ref=v0.12.0"

  allow_remote_vpc_dns_resolution = true
  auto_accept                     = true
  peer_cidr_range                 = "10.0.0.0/16"
  peer_route_1_enable             = true
  peer_route_1_table_id           = element(module.peer_base_network.private_route_tables, 0)
  peer_route_2_enable             = true
  peer_route_2_table_id           = element(module.peer_base_network.private_route_tables, 1)
  peer_vpc_id                     = module.peer_base_network.vpc_id
  vpc_cidr_range                  = "172.18.0.0/16"
  vpc_id                          = module.base_network.vpc_id
  vpc_route_1_enable              = true
  vpc_route_1_table_id            = element(module.base_network.private_route_tables, 0)
  vpc_route_2_enable              = true
  vpc_route_2_table_id            = element(module.base_network.private_route_tables, 1)
}

