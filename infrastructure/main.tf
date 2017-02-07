variable "apex_function_kinesis-lambda-pubnub" {
  default = ""
}

resource "aws_iam_role" "lambda_kinesis_execution_role" {
    name = "lambda_kinesis_execution_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis_execution_role_attach" {
    role = "${aws_iam_role.lambda_kinesis_execution_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaKinesisExecutionRole"
}

resource "aws_kinesis_stream" "kinesis-lambda-pubnub" {
    name = "kinesis-lambda-pubnub"
    shard_count = 1
    retention_period = 24
}

resource "aws_lambda_event_source_mapping" "kinesis-lambda-pubnub" {
    event_source_arn = "${aws_kinesis_stream.kinesis-lambda-pubnub.arn}"
    function_name = "${var.apex_function_kinesis-lambda-pubnub}"
    starting_position = "LATEST"
    batch_size = 100
}

output "role_arn" {
    value = "${aws_iam_role.lambda_kinesis_execution_role.arn}"
}
