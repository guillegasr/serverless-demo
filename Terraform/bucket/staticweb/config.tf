terraform {
  required_version = ">=  0.11.8"
  backend "s3" {
    bucket = "serverless-demo"
    key    = "../terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
}
variable "root_domain" {
  default = "epm.com"
}
