module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "4.1.0"

  name = "lms-import-data"
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "sqs-policy"
  description = "IAM policy for accessing SQS from EKS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage"
        ],
        Effect   = "Allow",
        Resource = local.sqs_resource
      },
    ],
  })
}

