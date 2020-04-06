locals {
  resource_id = "${var.create_resource ? element(concat(aws_api_gateway_resource.this.*.id, list("")), 0) : var.resource_id}"
  absolute_path = "${var.create_resource ? element(concat(aws_api_gateway_resource.this.*.path, list("")), 0) : var.path}"
}

resource "aws_api_gateway_resource" "this" {
  count = "${var.create_resource ? 1 : 0}"
  rest_api_id = "${var.root_id}"
  parent_id   = "${var.parent_id}"
  path_part   = "${var.path}"
}

resource "aws_api_gateway_method" "this" {
  rest_api_id   = "${var.root_id}"
  resource_id   = "${local.resource_id}"
  http_method   = "${var.http_method}"
  authorization = "${var.auth}"
}

resource "aws_api_gateway_method_response" "200" {
  rest_api_id = "${var.root_id}"
  resource_id = "${local.resource_id}"
  http_method = "${aws_api_gateway_method.this.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}
resource "aws_lambda_permission" "this" {
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_name}"
  principal ="apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.root_id}/*/${aws_api_gateway_method.this.http_method}${local.absolute_path}"
}


resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${var.root_id}"
  resource_id = "${aws_api_gateway_method.this.resource_id}"
  http_method = "${aws_api_gateway_method.this.http_method}"

//Lambda integration http method only supports POST
  integration_http_method = "POST" 
  type                    = "${var.resource_type}"
  uri                     = "${var.lambda_uri}"
  request_templates       = "${var.request_template}"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
}

resource "aws_api_gateway_integration_response" "this" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
  ]

  rest_api_id = "${var.root_id}"
  resource_id = "${local.resource_id}"
  http_method = "${aws_api_gateway_method.this.http_method}"
  status_code = "${aws_api_gateway_method_response.200.status_code}"

  response_templates {
    "application/json" = ""
  }
}
