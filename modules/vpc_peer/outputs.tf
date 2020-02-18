output "accept_status" {
  value       = aws_vpc_peering_connection.vpc_peer.accept_status
  description = "The status of the VPC Peering Connection request."
}

output "id" {
  value       = aws_vpc_peering_connection.vpc_peer.id
  description = "The ID of the VPC Peering Connection."
}
