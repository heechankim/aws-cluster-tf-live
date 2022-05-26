provider "aws" {
  region = "ap-northeast-2"
}


data "aws_subnet" "default-public1" {
  filter {
    name = "tag:ref"
    values = ["public1"]
  }
}
data "aws_subnet" "default-public2" {
  filter {
    name = "tag:ref"
    values = ["public2"]
  }
}

resource "aws_db_subnet_group" "prod-public" {
  name = "prod-mysql-subnet-groups"
  subnet_ids = [data.aws_subnet.default-public1.id, data.aws_subnet.default-public2.id]

  tags = {
    Name = "prod-mysql-subnet-groups"
    ref = "prod-db"
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "prod"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  db_subnet_group_name = aws_db_subnet_group.prod-public.name
  skip_final_snapshot = true

  db_name = "example_database"
  username = "admin"

  password = var.db_password
}

terraform {
  backend "s3" {
    bucket = "chan0-terraform-state"
    key = "prod/data-stores/mysql/terraform.tfstate" 
    region = "ap-northeast-2"

    dynamodb_table = "terraform-state-locks"
    encrypt = true
  }
}
