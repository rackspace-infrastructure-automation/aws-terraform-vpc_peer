output "acceptor_vpc_id" {
  description = "VPC ID of the accepting side's VPC"
  value       = module.acceptor_vpc.vpc_id
}

output "cross_account_role_arn" {
  description = "ARN of the accepting side's role for the requesting side to assume"
  value       = module.accept_vpc_peer.arn
}

output "external_id" {
  description = "External ID for the cross account IAM role for the requesting side to assume"
  value       = random_string.external_id.result
}

output "route_tables" {
  description = "Route tables to associate with the VPC peer"
  value       = module.acceptor_vpc.public_route_tables
}
