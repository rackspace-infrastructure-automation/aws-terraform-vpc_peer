module "acceptor_vpc" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork//?ref=v0.12.4"

  name = "VPCPeerAcceptorVPC"
}
