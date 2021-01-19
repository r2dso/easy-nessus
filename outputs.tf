output "nessus_instance_id" {
    value = aws_instance.nessus_server.id
}

output "nessus_ip" {
    value = aws_instance.nessus_server.public_ip
}