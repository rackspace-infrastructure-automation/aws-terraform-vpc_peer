# Cross Account Examples

The examples here are meant to demonstrate a basic VPC peer cross account setup.

## Acceptor

`acceptor` folder contain the resources required to setup the accepting side of the VPC peer link. `cross_account_iam_setup.tf` is the necessary resource required for setting up a cross account IAM role for the requesting side to assume and initiate the required tasks for peering setup. `aws_account` will be the account ID of the requesting side. `acceptor_vpc.tf` is a basic VPC example to setup a very basic VPC and can be left out if another module exists to handle the accepting side's VPC network. Please note that the requesting side's VPC peer request will need the following information about the accepting side's VPC network:

* Route tables for peering setup
* VPC ID

If you also have an IAM role already setup for the requesting side to assume for peering setup purposes you will need the following for the peer options:

* The full ARN of the IAM role on the accepting side
* The external ID if utilized

## Requester

`requester` contains the resources for the actual VPC peering setup. With the requesting side's VPC, it's important to remember that CIDR ranges need to be unique, so either the accepting side or requesting side will need to have non-default CIDR ranges if the base network module is mostly basic options. Examples of the values needed for the dynamic parts of the setup can be found in `acceptor/outputs.tf` as a base of reference in case a reference for which resource properties are required is necessary.
