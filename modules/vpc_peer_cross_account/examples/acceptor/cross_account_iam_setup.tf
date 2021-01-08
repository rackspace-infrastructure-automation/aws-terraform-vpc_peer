provider "aws" {
  version = "~> 2.1"
  region  = "us-west-2"
}

provider "random" {
  version = "~> 2.0"
}

resource "random_string" "external_id" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

data "aws_iam_policy_document" "accept_vpc_peer" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AcceptVpcPeeringConnection",
      "ec2:CreateRoute",
      "ec2:CreateTags",
      "ec2:DeleteRoute",
      "ec2:Describe*",
      "ec2:ModifyVpcPeeringConnectionOptions",
      "ec2:RejectVpcPeeringConnection",
    ]
  }
}

module "accept_vpc_peer" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.0"

  name        = "AcceptVpcPeer"
  aws_account = ["123456789012"]
  external_id = random_string.external_id.result

  inline_policy       = [data.aws_iam_policy_document.accept_vpc_peer.json]
  inline_policy_count = 1

}
