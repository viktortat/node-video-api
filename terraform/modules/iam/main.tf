/*
  --- IAM Policy Data Document(s) --- 
*/

data "aws_iam_policy_document" "get_s3_contents_lambda_policy_document" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${var.s3_arn}",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "get_signed_url_lambda_policy_document" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "${var.s3_arn}",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "lambda_assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

/*
  --- IAM Policies ---  
*/

resource "aws_iam_policy" "get_s3_contents_lambda_policy" {
  name        = "get-s3-contents-lambda-policy-${terraform.workspace}"
  description = "A policy that allows a lambda function to list the contents of an S3 bucket"
  policy      = "${data.aws_iam_policy_document.get_s3_contents_lambda_policy_document.json}"
}

resource "aws_iam_policy" "get_signed_url_lambda_policy" {
  name        = "get-signed-url-lambda-policy-${terraform.workspace}"
  description = "A policy that allows a lambda function to generate a signed url for an object in an S3 bucket"
  policy      = "${data.aws_iam_policy_document.get_signed_url_lambda_policy_document.json}"
}

/*
  --- IAM Roles --- 
*/

resource "aws_iam_role" "get_s3_contents_lambda_role" {
  name               = "get-s3-contents-lambda-role-${terraform.workspace}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy_document.json}"
}

resource "aws_iam_role" "get_signed_url_lambda_role" {
  name               = "get-signed-url-lambda-role-${terraform.workspace}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy_document.json}"
}

/*
  --- Policy/Role Attachement ---
*/

resource "aws_iam_policy_attachment" "get_s3_contents_lambda_attachment" {
  name       = "get-s3-contents-lambda-attachment-${terraform.workspace}"
  roles      = ["${aws_iam_role.get_s3_contents_lambda_role.name}"]
  policy_arn = "${aws_iam_policy.get_s3_contents_lambda_policy.arn}"
}

resource "aws_iam_policy_attachment" "get_signed_url_lambda_attachment" {
  name       = "get-signed-url-lambda-attachment-${terraform.workspace}"
  roles      = ["${aws_iam_role.get_signed_url_lambda_role.name}"]
  policy_arn = "${aws_iam_policy.get_signed_url_lambda_policy.arn}"
}
