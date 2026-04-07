terraform {
  cloud {

    organization = "mtc-tf-jwson"

    workspaces {
      name = "state-buckets"
    }
  }
}
locals {
  buckets = {
    "dev"  = "mtc-app-state"
    "prod" = "mtc-app-state-2"
  }
}
import {
  for_each = local.buckets
  to       = aws_s3_bucket.this[each.key]
  id       = each.value
}
resource "aws_s3_bucket" "this" {
  for_each = local.buckets
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
  default_tags {
    tags = { App = "mtc-app" }
  }
}
