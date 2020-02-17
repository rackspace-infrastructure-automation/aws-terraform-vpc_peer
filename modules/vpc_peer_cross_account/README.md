# aws-terraform-vpc\_peer/modules/vpc\_peer\_cross\_account

This module requires AWS Credentials for the Acceptor account in the cross account case. The IAM user must miminally have the below permissions to manage the entire lifecyle of the peering connection including route manipulation.

```
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Sid": "demo",
           "Effect": "Allow",
           "Action": [
               "ec2:AcceptVpcPeeringConnection",
               "ec2:CreateRoute",
               "ec2:CreateTags",
               "ec2:DeleteRoute",
               "ec2:DescribeRouteTables",
               "ec2:DescribeTags",
               "ec2:DescribeVpcPeeringConnections",
               "ec2:ModifyVpcPeeringConnectionOptions",
               "ec2:RejectVpcPeeringConnection"
          ],
          "Resource": "*"
       }
   ]
}
```

**NOTE 1:** To use the `cross_account.tf` example create a file called `secrets.tf` similar to the `secrets.tf.example` file in the `examples` folder.

**NOTE 2:** To create an inter-region peering connection, specify the origin AWS account number as the value for the `peer_owner_id` parameter.

## Basic Usage

```
module "cross_account_vpc_peer" {
 source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.12.0"

 vpc_id = module.base_network.vpc_id

 # VPC in acceptor account vpc-XXXXXXXXX
 peer_vpc_id = "vpc-XXXXXXXXX"

 # Acceptor account number
 peer_owner_id = "XXXXXXXXXXXXX"

 # Acceptor VPC Region
 peer_region = "us-west-2"

 # Acceptor Access and Secret Key.
 # These are added inline for clarity but should never be commited directly to the terraform config as seen here.
 # Use a local secrets.tf as seen in example directory
 acceptor_access_key = "ACCESS_KEY_HERE"
 acceptor_secret_key = "SECRET_KEY_HERE"

 vpc_cidr_range = "172.18.0.0/16"

 # Acceptor cidr Range e.g. 172.19.0.0/16
 peer_cidr_range = "X.X.X.X/16"

 vpc_route_1_enable   = true
 vpc_route_1_table_id = element(module.base_network.private_route_tables, 0)
 vpc_route_2_enable   = true
 vpc_route_2_table_id = element(module.base_network.private_route_tables, 1)

 # Acceptor Route Tables
 # Acceptor Route Table ID rtb-XXXXXXX
 peer_route_1_enable = true

 peer_route_1_table_id = "rtb-XXXXX"
 peer_route_2_enable   = true
 peer_route_2_table_id = "rtb-XXXXX"
}
```

Full working references are available at [examples](examples)

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.31.0 |
| aws.peer | >= 2.31.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acceptor\_access\_key | An AWS Access Key with permissions to setup a VPC on the alternate account. Only set for cross account use cases. | `string` | `""` | no |
| acceptor\_secret\_key | An AWS Secret Key with permissions to setup a VPC on the alternate account. Only set for cross account use cases. | `string` | `""` | no |
| allow\_remote\_vpc\_dns\_resolution | Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | `string` | `true` | no |
| environment | Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test') | `string` | `"Development"` | no |
| peer\_cidr\_range | Peer VPC CIDR Range e.g. 172.19.0.0/16 | `string` | `"172.19.0.0/16"` | no |
| peer\_owner\_id | The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to. (OPTIONAL) | `string` | `""` | no |
| peer\_region | The region of the accepter VPC of the [VPC Peering Connection]. | `string` | `""` | no |
| peer\_route\_1\_enable | Enables Peer Route Table 1. Allowed values: true, false | `string` | `false` | no |
| peer\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_2\_enable | Enables Peer Route Table 2. Allowed values: true, false | `string` | `false` | no |
| peer\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_3\_enable | Enables Peer Route Table 3. Allowed values: true, false | `string` | `false` | no |
| peer\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_4\_enable | Enables Peer Route Table 4. Allowed values: true, false | `string` | `false` | no |
| peer\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX | `string` | `""` | no |
| peer\_route\_5\_enable | Enables Peer Route Table 5. Allowed values: true, false | `string` | `false` | no |
| peer\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX | `string` | `""` | no |
| peer\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection. | `string` | n/a | yes |
| tags | Custom tags to apply to all resources. | `map(string)` | `{}` | no |
| vpc\_cidr\_range | VPC CIDR Range e.g. 172.18.0.0/16 | `string` | `"172.18.0.0/16"` | no |
| vpc\_id | The ID of the requester VPC. | `string` | n/a | yes |
| vpc\_route\_1\_enable | Enables VPC Route Table 1. Allowed values: true, false | `string` | `false` | no |
| vpc\_route\_1\_table\_id | ID of VPC Route table #1 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_2\_enable | Enables VPC Route Table 2. Allowed values: true, false | `string` | `false` | no |
| vpc\_route\_2\_table\_id | ID of VPC Route table #2 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_3\_enable | Enables VPC Route Table 3. Allowed values: true, false | `string` | `false` | no |
| vpc\_route\_3\_table\_id | ID of VPC Route table #3 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_4\_enable | Enables VPC Route Table 4. Allowed values: true, false | `string` | `false` | no |
| vpc\_route\_4\_table\_id | ID of VPC Route table #4 rtb-XXXXXX | `string` | `""` | no |
| vpc\_route\_5\_enable | Enables VPC Route Table 5. Allowed values: true, false | `string` | `false` | no |
| vpc\_route\_5\_table\_id | ID of VPC Route table #5 rtb-XXXXXX | `string` | `""` | no |

## Outputs

No output.

