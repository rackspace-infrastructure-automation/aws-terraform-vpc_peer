# VPC Peering

# Description
The module sets up a VPC peer within an AWS Account or in an alternate AWS Account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allow_remote_vpc_dns_resolution | Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | string | `true` | no |
| auto_accept | Accept the peering (both VPCs need to be in the same AWS account). (OPTIONAL). | string | `false` | no |
| environment | Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test') | string | `Development` | no |
| peer_owner_id | The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to. (OPTIONAL) | string | `` | no |
| peer_region | The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side. (OPTIONAL) | string | `` | no |
| peer_vpc_id | The ID of the VPC with which you are creating the VPC Peering Connection. | string | - | yes |
| tags | Custom tags to apply to all resources. | map | `<map>` | no |
| vpc_id | The ID of the requester VPC. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| accept_status | The status of the VPC Peering Connection request. |
| id | The ID of the VPC Peering Connection. |