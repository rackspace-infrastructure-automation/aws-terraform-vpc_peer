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
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_peer//modules/vpc_peer_cross_account?ref=v0.12.0"

  vpc_id = module.base_network.vpc_id

  # VPC in acceptor account vpc-XXXXXXXXX
  peer_vpc_id = "vpc-XXXXXXXXX"

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

No output.

