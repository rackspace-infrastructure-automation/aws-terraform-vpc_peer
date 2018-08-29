## VPC Peer Cross Account

## Basic Usage
This module requires AWS Credentials for the Acceptor account.

To use the `cross_account.tf` example create a file called `secrets.tf` in the `example` folder and populate it with the following, replacing the X's with the Acceptor's account credentials.

```
variable "acceptor_access_key" {
  default = "XXXXXXXXXXXX"
}

variable "acceptor_secret_key" {
  default = "XXXXXXXXXX"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acceptor_access_key | An AWS Access Key with permissions to setup a VPC on the alternate account. | string | - | yes |
| acceptor_secret_key | An AWS Secret Key with permissions to setup a VPC on the alternate account. | string | - | yes |
| allow_remote_vpc_dns_resolution | Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | string | `true` | no |
| auto_accept | Accept the peering (both VPCs need to be in the same AWS account). (OPTIONAL). | string | `false` | no |
| environment | Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test') | string | `Development` | no |
| peer_owner_id | The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to. (OPTIONAL) | string | `` | no |
| peer_region | The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side. (OPTIONAL) | string | `` | no |
| peer_vpc_id | The ID of the VPC with which you are creating the VPC Peering Connection. | string | - | yes |
| tags | Custom tags to apply to all resources. | map | `<map>` | no |
| vpc_id | The ID of the requester VPC. | string | - | yes |
