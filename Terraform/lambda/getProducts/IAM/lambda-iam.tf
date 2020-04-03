resource "aws_iam_role_policy" "test_lambda_policy" {
  name = "test_lambda_policy"
  role = "${aws_iam_role.lambda_role.id}"

  policy = "${file("IAM/lambda-policy.json")}"
}

resource "aws_iam_role" "lambda_role" {
  name = "test_lambda_role"
  assume_role_policy =  "${file("IAM/lambda-assume-policy.json")}"
}