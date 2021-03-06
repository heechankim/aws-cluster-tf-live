provider "aws" {
  region = "ap-northeast-2"
}

module "webserver_cluster" {
  source = "https://github.com/heechankim/aws-cluster-tf-module/tree/main/services/webserver-cluster?ref=v0.0.1" 

  cluster_name = "webservers-prod"
  db_remote_state_bucket = "chan0-terraform-state"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 4
}
