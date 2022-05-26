provider "aws" {
  region = "ap-northeast-2"
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "chan0-terraform-state"

  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

#terraform {
#  backend "s3" {
#    bucket = "chan0-terraform-state"
#    key = "stage/services/webserver-cluster/terraform.tfstate"
#    region = "ap-northeast-2"
#
#    dynamodb_table = "terraform-state-locks"
#    encrypt = true
#  }
#}
