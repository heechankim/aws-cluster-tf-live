output "address" {
  value = aws_db_instance.example.address
  description = "Connect to the prod-database at this endpoint"
}

output "port" {
  value = aws_db_instance.example.port
  description = "The Port the prod-database is listening on"
}
