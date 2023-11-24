module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket = "my-web-assets-mtl-test"

  force_destroy = true
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
        Resource = local.s3_resource
      },
    ],
  })
}

