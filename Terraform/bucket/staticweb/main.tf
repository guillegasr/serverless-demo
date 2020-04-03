data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    bucket = "server-less"
    key    = "../terraform.tfstate"
    region = "us-west-2"
  }
}

resource "aws_s3_bucket" "webapp" {
  bucket = "${terraform.workspace}.${var.root_domain}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = "${merge(data.terraform_remote_state.global.tags,
  map (
    "name", "s3bucket_webapp_${terraform.workspace}", 
    "description", "bucket for static web app",
    "status", "${terraform.workspace}"
    )
  )}"
}


