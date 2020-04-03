locals {
  lambda_zip_location = "outputs/welcome.zip"
}

data "archive_file" "welcome" {
  type = "zip"
  source_file = "welcome.py"
  output_path = "${local.lambda_zip_location}"
}