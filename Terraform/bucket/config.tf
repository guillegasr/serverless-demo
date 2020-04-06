 terraform {
 backend "s3" {
    bucket = "serverless-demo"
    key    = ".../terraform.tfstate"
    region = "us-west-2"
  }
}

variable "global_tags" {
  default = {
    enviroment  = "sandbox"
    application = "epm"
    status      = "test_development"
    managedBy   = "terraform"
  }
}
