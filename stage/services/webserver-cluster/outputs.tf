output "alb_dns_name" {
  description = "The Domain Name of the staging load balancer"
  value = module.webserver_cluster.alb_dns_name
}
