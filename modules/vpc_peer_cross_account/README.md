# aws-terraform-vpc\_peer/modules/vpc\_peer\_cross\_account

This module requires AWS Credentials for the peer account in the cross account case. The IAM user  
or IAM role must miminally have the below permissions to manage the entire lifecyle of the peering  
connection including route manipulation.  An example of the required [IAM Role](examples/cross\_account\_iam\_setup.tf)  
can be used to create the required role.

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
               "ec2:Describe*",
               "ec2:ModifyVpcPeeringConnectionOptions",
               "ec2:RejectVpcPeeringConnection"
          ],
          "Resource": "*"
       }
   ]
}
```

## Basic Usage

```HCL
module "cross_account_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.12.2"

  vpc_id = module.base_network.vpc_id

  # VPC in acceptor account vpc-XXXXXXXXX
  peer_vpc_id = module.peer_base_network.vpc_id

  vpc_route_tables       = module.base_network.private_route_tables
  vpc_route_tables_count = 2

  # Acceptor Route Tables
  peer_route_tables       = module.peer_base_network.private_route_tables
  peer_route_tables_count = 2

  providers = {
    aws.peer = aws.peer
  }
}
```

### Cross account provider example

```HCL
provider "aws" {
  version = "~> 2.31"

  alias  = "peer"
  region = "us-west-2"

  assume_role {
    role_arn    = "arn:aws:iam::123456789012:role/AcceptVpcPeer"
    external_id = "SomeExternalId"
  }
}
```

### Cross region provider example

```HCL
provider "aws" {
  alias  = "peer"
  region = "us-east-1"
}
```

Full working references are available at [examples](examples)

## Terraform 0.12 upgrade

Several changes were required while adding terraform 0.12 compatibility.  The following changes should be  
made when upgrading from a previous release to version 0.12.0 or higher.

### Required provider

The module now requires an explicitly defined AWS provider to be provided for the peer region and\or account.  
The examples have been updated to demonstrate passing in the provider.  As long as the peer information is  
not changed, no resources should be replaced as a result of this change.

### Module variables

The following module variables were removed and are no longer neccessary:

- `acceptor_access_key`
- `acceptor_secret_key`
- `peer_cidr_range`
- `peer_owner_id`
- `peer_region`
- `vpc_cidr_range`

New variables `peer_route_tables` and `peer_route_tables_count` were added to replace the functionality of the various `peer_route_x_enable` and `peer_route_x_table_id` variables.  These deprecated variables and resources will continue to work as expected, but will be removed in a future release.

New variables `vpc_route_tables` and `vpc_route_tables_count` were added to replace the functionality of the various `vpc_route_x_enable` and `vpc_route_x_table_id` variables.  These deprecated variables and resources will continue to work as expected, but will be removed in a future release.

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.31.0 |
| aws.peer | >= 2.31.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allow\_remote\_vpc\_dns\_resolution | Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | `bool` | `true` | no |
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

No output.

