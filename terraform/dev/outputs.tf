output "lb_public_ip" {
  value = module.lb_ec2.public_ip
}

output "web_public_ip" {
  value = module.web_ec2.public_ip
}

output "db_public_ip" {
  value = module.db_ec2.public_ip
}

output "private_ssh_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}