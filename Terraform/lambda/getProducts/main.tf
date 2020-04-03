resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lambda_zip_location}"
  function_name = "getProducts_test"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "Products.getProducts"

  source_code_hash = "${filebase64sha256("getProducts.zip")}"

  runtime = "python3.7"
}