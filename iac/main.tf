locals {
  cluster_name = "mtl-test-cluster"
  key_name     = "mtl-test"
  sqs_resource = "${module.sqs.queue_arn}"
  s3_resource = [
    "${module.s3_bucket.s3_bucket_arn}",
    "${module.s3_bucket.s3_bucket_arn}/*",
  ]
}

