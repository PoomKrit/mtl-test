module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.0.3"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3a.small"
      key_name      = "your-ec2-keypair"
    }
  }

  workers_additional_policies = [aws_iam_policy.s3_policy.arn, aws_iam_policy.sqs_policy.arn]
}

resource "aws_iam_policy" "s3_policy" {
  name        = "s3-policy"
  description = "IAM policy for accessing S3 from EKS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::my-web-assets/*"
      },
    ],
  })
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
        Resource = "arn:aws:sqs:ap-southeast-1:123456789123:lms-import-data"
      },
    ],
  })
}

