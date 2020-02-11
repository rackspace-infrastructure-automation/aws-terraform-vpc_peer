## aws-terraform-vpc_peer

This repository contains terraform modules that can be used to deploy a VPC Peer.

This module was tested against aws provider version `2.31.0` and minimally requires this version to produce expected results.

## Module Listing
- [VPC Peer](./modules/vpc_peer) - A Terraform module for creating a VPC Peer within the same AWS account.
- [VPC Peer Cross Account / Inter-Region](./modules/vpc_peer_cross_account) - A Terraform module for creating a VPC Peer across different AWS accounts and/or regions.
