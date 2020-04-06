variable "root_id" {}
variable "parent_id" {}
variable "path" {
  description = "When API GW Resource is being created, this should be a relative path but when not this should be the absolute path to the resource" 
}
variable "http_method" {}

variable "request_template" {
  default = {
    "application/json" = <<EOF
{
"httpMethod": "$context.httpMethod",
"body" : "$util.escapeJavaScript($input.json('$'))",
"headers": {
   #foreach($param in $input.params().header.keySet())
   "$param": "$util.escapeJavaScript($input.params().header.get($param))" #if($foreach.hasNext),#end

   #end
},
"queryStringParameters": {
   #foreach($param in $input.params().querystring.keySet())
   "$param": "$util.escapeJavaScript($input.params().querystring.get($param))" #if($foreach.hasNext),#end

   #end
},
"pathParameters": {
   #foreach($param in $input.params().path.keySet())
   "$param": "$util.escapeJavaScript($input.params().path.get($param))" #if($foreach.hasNext),#end

   #end
},
"path" : "$context.resourcePath"
}
      EOF
  }
}

variable "auth" {
  default = "NONE"
}

variable "resource_type" {
  default = "AWS"
}

variable "lambda_uri" {
  default = "dummy"
}
variable "lambda_arn" {
  default = "dummy"
}
variable "lambda_name" {
  default = "dummy"
}
variable "integration_http_method" {
  default = "POST"
}

variable "account_id" {
    default = "730283099005"
}
variable "region" {
    default ="us-west-2"
}
variable "create_resource" {
    default = true
}
variable "resource_id" {
    default = "dummy"
}

variable "resource_absolute_path" {
  default = "dummy"
}
output "resource_id" {
 value = "${local.resource_id}"
}
output "resource_absolute_part" {
  description = "Resource_absolute_path is only working when API GW Resouce is being  created"
  value = "${local.absolute_path}"
}

