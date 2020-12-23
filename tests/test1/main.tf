terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-east-2"
  alias   = "ohio"
}

module "base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=master"

  cidr_range          = "172.18.0.0/16"
  name                = "VPC-Peer-Origin"
  private_cidr_ranges = ["172.18.0.0/21", "172.18.8.0/21"]
  public_cidr_ranges  = ["172.18.168.0/22", "172.18.172.0/22"]
}

module "peer_base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=master"

  cidr_range          = "10.0.0.0/16"
  name                = "VPC-Peer-Accepter"
  private_cidr_ranges = ["10.0.2.0/24", "10.0.4.0/24"]
  public_cidr_ranges  = ["10.0.1.0/24", "10.0.3.0/24"]
}

module "remote_peer_base_network" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=master"

  cidr_range          = "192.168.0.0/16"
  name                = "Remote-VPC-Peer-Accepter"
  private_cidr_ranges = ["192.168.0.0/21", "192.168.8.0/21"]
  public_cidr_ranges  = ["192.168.168.0/22", "192.168.172.0/22"]

  providers = {
    aws = aws.ohio
  }
}

module "vpc_peer" {
  source = "../../module/modules/vpc_peer"

  allow_remote_vpc_dns_resolution = true
  auto_accept                     = true
  peer_route_tables               = concat(module.peer_base_network.public_route_tables, module.peer_base_network.private_route_tables)
  peer_route_tables_count         = 3
  peer_vpc_id                     = module.peer_base_network.vpc_id
  vpc_id                          = module.base_network.vpc_id
  vpc_route_tables                = concat(module.base_network.public_route_tables, module.base_network.private_route_tables)
  vpc_route_tables_count          = 3
}

data "aws_caller_identity" "current" {
}

module "cross_account_vpc_peer" {
  source = "../../module/modules/vpc_peer_cross_account"

  peer_route_tables       = concat(module.remote_peer_base_network.public_route_tables, module.remote_peer_base_network.private_route_tables)
  peer_route_tables_count = 3
  peer_vpc_id             = module.remote_peer_base_network.vpc_id
  vpc_id                  = module.base_network.vpc_id
  vpc_route_tables        = concat(module.base_network.public_route_tables, module.base_network.private_route_tables)
  vpc_route_tables_count  = 3

  providers = {
    aws.peer = aws.ohio
  }
}

resource "random_string" "external_id" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

data "aws_iam_policy_document" "accept_vpc_peer" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AcceptVpcPeeringConnection",
      "ec2:CreateRoute",
      "ec2:CreateTags",
      "ec2:DeleteRoute",
      "ec2:Describe*",
      "ec2:ModifyVpcPeeringConnectionOptions",
      "ec2:RejectVpcPeeringConnection",
    ]
  }
}

data "aws_canonical_user_id" "current" {}

module "accept_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=master"

  name        = "AcceptVpcPeer"
  aws_account = [data.aws_caller_identity.current.account_id]
  external_id = random_string.external_id.result

  inline_policy       = [data.aws_iam_policy_document.accept_vpc_peer.json]
  inline_policy_count = 1
}
