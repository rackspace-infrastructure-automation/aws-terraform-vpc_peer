# aws-terraform-vpc\_peer/modules/vpc\_peer

The module sets up a VPC peer in a single region and AWS Account. For inter region  
and cross account VPC peering see the companion [cross account module ](../vpc\_peer\_cross\_account)

## Basic Usage

```
module "vpc_peer" {
 source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer?ref=v0.12.2"

 vpc_id                          = module.base_network.vpc_id
 peer_vpc_id                     = module.peer_base_network.vpc_id
 auto_accept                     = true
 allow_remote_vpc_dns_resolution = true

 #  VPC Routes
 vpc_route_tables       = module.base_network.private_route_tables
 vpc_route_tables_count = 2

 # Peer Routes
 peer_route_tables       = module.peer_base_network.private_route_tables
 peer_route_tables_count = 2
}
```

Full working references are available at [examples](examples)

## Terraform 0.12 upgrade

Several changes were required while adding terraform 0.12 compatibility.  The following changes should be  
made when upgrading from a previous release to version 0.12.0 or higher.

### Module variables

The following module variables were removed and are no longer neccessary:

- `peer_cidr_range`
- `vpc_cidr_range`

New variables `peer_route_tables` and `peer_route_tables_count` were added to replace the functionality of the various `peer_route_x_enable` and `peer_route_x_table_id` variables.  These deprecated variables and resources will continue to work as expected, but will be removed in a future release.

New variables `vpc_route_tables` and `vpc_route_tables_count` were added to replace the functionality of the various `vpc_route_x_enable` and `vpc_route_x_table_id` variables.  These deprecated variables and resources will continue to work as expected, but will be removed in a future release.

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.31.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allow\_remote\_vpc\_dns\_resolution | Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | `bool` | `true` | no |
| auto\_accept | Accept the peering. | `bool` | `false` | no |
| environment | Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test') | `string` | `"Development"` | no |
| peer\_route\_1\_enable | Enables Peer Route Table 1. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `bool` | `false` | no |
| peer\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `string` | `""` | no |
| peer\_route\_2\_enable | Enables Peer Route Table 2. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `bool` | `false` | no |
| peer\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `string` | `""` | no |
| peer\_route\_3\_enable | Enables Peer Route Table 3. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `bool` | `false` | no |
| peer\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `string` | `""` | no |
| peer\_route\_4\_enable | Enables Peer Route Table 4. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `bool` | `false` | no |
| peer\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `string` | `""` | no |
| peer\_route\_5\_enable | Enables Peer Route Table 5. (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `bool` | `false` | no |
| peer\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `peer_route_tables` and `peer_route_tables_count` variables. | `string` | `""` | no |
| peer\_route\_tables | A list of all peer route tables IDs | `list(string)` | `[]` | no |
| peer\_route\_tables\_count | The number of peer route tables | `number` | `0` | no |
| peer\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection. | `string` | n/a | yes |
| tags | Custom tags to apply to all resources. | `map(string)` | `{}` | no |
| vpc\_id | The ID of the requester VPC. | `string` | n/a | yes |
| vpc\_route\_1\_enable | Enables VPC Route Table 1. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `bool` | `false` | no |
| vpc\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `string` | `""` | no |
| vpc\_route\_2\_enable | Enables VPC Route Table 2. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `bool` | `false` | no |
| vpc\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `string` | `""` | no |
| vpc\_route\_3\_enable | Enables VPC Route Table 3. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `bool` | `false` | no |
| vpc\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `string` | `""` | no |
| vpc\_route\_4\_enable | Enables VPC Route Table 4. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `bool` | `false` | no |
| vpc\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `string` | `""` | no |
| vpc\_route\_5\_enable | Enables VPC Route Table 5. (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `bool` | `false` | no |
| vpc\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX (Deprecated) This variable will be removed in future releases in favor of the `vpc_route_tables` and `vpc_route_tables_count` variables. | `string` | `""` | no |
| vpc\_route\_tables | A list of all VPC route tables IDs | `list(string)` | `[]` | no |
| vpc\_route\_tables\_count | The number of VPC route tables | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| accept\_status | The status of the VPC Peering Connection request. |
| id | The ID of the VPC Peering Connection. |

