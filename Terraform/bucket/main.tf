provider "aws" {
  region = "us-west-2"
}

data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    bucket = "serverless-demo"
    key    = ".../terraform.tfstate"
    region = "us-west-2"
  }
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "serverless-demo"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = "${merge(var.global_tags,
  map (
    "name", "serverless-demo", 
    "description", "bucket to store artifacts"
    )
  )}"
}
