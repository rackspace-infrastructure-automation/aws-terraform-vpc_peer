## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.1 |
| random | ~> 2.0 |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| acceptor\_vpc\_id | VPC ID of the accepting side's VPC |
| cross\_account\_role\_arn | ARN of the accepting side's role for the requesting side to assume |
| external\_id | External ID for the cross account IAM role for the requesting side to assume |
| route\_tables | Route tables to associate with the VPC peer |

