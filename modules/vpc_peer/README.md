# aws-terraform-vpc\_peer/modules/vpc\_peer

The module sets up a VPC peer in a single region and AWS Account. For inter region  
and cross account VPC peering see the companion [cross account module ](../vpc\_peer\_cross\_account)

## Basic Usage

```
module "vpc_peer" {
 source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer?ref=v0.12.0"

 vpc_id                          = module.base_network.vpc_id
 peer_vpc_id                     = module.peer_base_network.vpc_id
 auto_accept                     = true
 allow_remote_vpc_dns_resolution = true

 #  VPC Routes
 vpc_route_1_enable   = true
 vpc_route_1_table_id = element(module.base_network.private_route_tables, 0)
 vpc_route_2_enable   = true
 vpc_route_2_table_id = element(module.base_network.private_route_tables, 1)

 # Peer Routes
 peer_route_1_enable   = true
 peer_route_1_table_id = element(module.peer_base_network.private_route_tables, 0)
 peer_route_2_enable   = true
 peer_route_2_table_id = element(module.peer_base_network.private_route_tables, 1)
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
| peer\_route\_1\_enable | Enables Peer Route Table 1. Allowed values: true, false | `bool` | `false` | no |
| peer\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_2\_enable | Enables Peer Route Table 2. Allowed values: true, false | `bool` | `false` | no |
| peer\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_3\_enable | Enables Peer Route Table 3. Allowed values: true, false | `bool` | `false` | no |
| peer\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_4\_enable | Enables Peer Route Table 4. Allowed values: true, false | `bool` | `false` | no |
| peer\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_5\_enable | Enables Peer Route Table 5. Allowed values: true, false | `bool` | `false` | no |
| peer\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX | `string` | `""` | no |
| peer\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection. | `string` | n/a | yes |
| tags | Custom tags to apply to all resources. | `map(string)` | `{}` | no |
| vpc\_id | The ID of the requester VPC. | `string` | n/a | yes |
| vpc\_route\_1\_enable | Enables VPC Route Table 1. Allowed values: true, false | `bool` | `false` | no |
| vpc\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_2\_enable | Enables VPC Route Table 2. Allowed values: true, false | `bool` | `false` | no |
| vpc\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_3\_enable | Enables VPC Route Table 3. Allowed values: true, false | `bool` | `false` | no |
| vpc\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_4\_enable | Enables VPC Route Table 4. Allowed values: true, false | `bool` | `false` | no |
| vpc\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_5\_enable | Enables VPC Route Table 5. Allowed values: true, false | `bool` | `false` | no |
| vpc\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| accept\_status | The status of the VPC Peering Connection request. |
| id | The ID of the VPC Peering Connection. |

