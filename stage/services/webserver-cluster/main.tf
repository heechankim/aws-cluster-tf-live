provider "aws" {
  region = "ap-northeast-2"
}

# aws-cluster-tf-module-0.0.1/services/webserver-cluster

module "webserver_cluster" {
  source = "https://github.com/heechankim/aws-cluster-tf-module/archive/refs/tags/v0.0.1.zip//aws-cluster-tf-module-0.0.1/services/webserver-cluster" 

  cluster_name = "webservers-stage"
  db_remote_state_bucket = "chan0-terraform-state"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate" 
  instance_type = "t3a.nano"
  min_size = 2
  max_size = 4
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type = "ingress"

  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port = 12060
  to_port = 12060
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

