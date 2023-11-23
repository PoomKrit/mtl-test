terraform {
  required_version = "~> 1.2" # which means any version equal & above 1.0 like 1.1, 1.2 etc and < 2.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  # backend "s3" {
  #   bucket  = "mtl-test-tf-state-bucket"
  #   key     = "go-app/terraform.tfstate"
  #   region  = "ap-southeast-1"
  #   encrypt = true
  #   profile = "mtl-test"
  # }
}

provider "aws" {
  region = "ap-southeast-1"
  profile = "mtl-test"
}
