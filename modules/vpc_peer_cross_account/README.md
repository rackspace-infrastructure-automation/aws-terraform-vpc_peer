# aws-terraform-vpc_peer/modules/vpc_peer_cross_account

This module requires AWS Credentials for the Acceptor account.

To use the `cross_account.tf` or `inter_region.tf` examples, create a file called `secrets.tf` in the `example` folder, and populate it with the following, replacing the X's with the Acceptor's account credentials.

**NOTE:** To create an inter-region peering connection, specify the origin AWS account number as the value for the `peer_owner_id` parameter. You must also set the `is_inter_region` parameter to `true` in order to prevent the module from attempting to set unsupported peering connection options.

## Basic Usage

```
module "cross_account_vpc_peer" {
 source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.0.2"
 vpc_id = "${module.base_network.vpc_id}"

 # VPC in acceptor account vpc-XXXXXXXXX
 peer_vpc_id = "vpc-XXXXXXXXX"

 # Acceptor account number
 peer_owner_id = "XXXXXXXXXXXXX"

 # Acceptor VPC Region
 peer_region = "us-west-2"

 # Acceptor Secret Key. Use a local secrets.tf file
 acceptor_access_key = "${var.acceptor_access_key}"
 acceptor_secret_key = "${var.acceptor_secret_key}"

 vpc_cidr_range = "172.18.0.0/16"

 # Acceptor cidr Range e.g. 172.19.0.0/16
 peer_cidr_range = "X.X.X.X/16"

 vpc_route_1_enable   = true
 vpc_route_1_table_id = "${element(module.base_network.private_route_tables, 0)}"
 vpc_route_2_enable   = true
 vpc_route_2_table_id = "${element(module.base_network.private_route_tables, 1)}"

 # Acceptor Route Tables
 # Acceptor Route Table ID rtb-XXXXXXX
 peer_route_1_enable = true

 peer_route_1_table_id = "rtb-XXXXX"
 peer_route_2_enable   = true
 peer_route_2_table_id = "rtb-XXXXX"
}
```

Full working references are available at [examples](examples)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acceptor\_access\_key | An AWS Access Key with permissions to setup a VPC on the alternate account. | string | n/a | yes |
| acceptor\_secret\_key | An AWS Secret Key with permissions to setup a VPC on the alternate account. | string | n/a | yes |
| allow\_remote\_vpc\_dns\_resolution | Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | string | `"true"` | no |
| auto\_accept | Accept the peering (both VPCs need to be in the same AWS account). (OPTIONAL). | string | `"false"` | no |
| environment | Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test') | string | `"Development"` | no |
| is\_inter\_region | Whether or not the VPC Peering connection being established is inter-region. | string | `"false"` | no |
| peer\_cidr\_range | Peer VPC CIDR Range e.g. 172.19.0.0/16 | string | `"172.19.0.0/16"` | no |
| peer\_owner\_id | The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to. (OPTIONAL) | string | `""` | no |
| peer\_region | The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side. (OPTIONAL) | string | `""` | no |
| peer\_route\_1\_enable | Enables Peer Route Table 1. Allowed values: true, false | string | `"false"` | no |
| peer\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX | string | `""` | no |
| peer\_route\_2\_enable | Enables Peer Route Table 2. Allowed values: true, false | string | `"false"` | no |
| peer\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX | string | `""` | no |
| peer\_route\_3\_enable | Enables Peer Route Table 3. Allowed values: true, false | string | `"false"` | no |
| peer\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX | string | `""` | no |
| peer\_route\_4\_enable | Enables Peer Route Table 4. Allowed values: true, false | string | `"false"` | no |
| peer\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX | string | `""` | no |
| peer\_route\_5\_enable | Enables Peer Route Table 5. Allowed values: true, false | string | `"false"` | no |
| peer\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX | string | `""` | no |
| peer\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection. | string | n/a | yes |
| tags | Custom tags to apply to all resources. | map | `<map>` | no |
| vpc\_cidr\_range | VPC CIDR Range e.g. 172.18.0.0/16 | string | `"172.18.0.0/16"` | no |
| vpc\_id | The ID of the requester VPC. | string | n/a | yes |
| vpc\_route\_1\_enable | Enables VPC Route Table 1. Allowed values: true, false | string | `"false"` | no |
| vpc\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX | string | `""` | no |
| vpc\_route\_2\_enable | Enables VPC Route Table 2. Allowed values: true, false | string | `"false"` | no |
| vpc\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX | string | `""` | no |
| vpc\_route\_3\_enable | Enables VPC Route Table 3. Allowed values: true, false | string | `"false"` | no |
| vpc\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX | string | `""` | no |
| vpc\_route\_4\_enable | Enables VPC Route Table 4. Allowed values: true, false | string | `"false"` | no |
| vpc\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX | string | `""` | no |
| vpc\_route\_5\_enable | Enables VPC Route Table 5. Allowed values: true, false | string | `"false"` | no |
| vpc\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX | string | `""` | no |

