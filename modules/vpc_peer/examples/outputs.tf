output "peer_id_output" {
  description = "ID of the VPC Peer"
  value       = module.vpc_peer.id
}

output "accept_status_output" {
  description = "Output of the Accect Status"
  value       = module.vpc_peer.accept_status
}

