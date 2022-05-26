output "alb_dns_name" {
  description = "The Domain Name of the production load balancer"
  value = module.webserver_cluster.alb_dns_name
}
