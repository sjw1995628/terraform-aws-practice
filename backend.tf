terraform {
  cloud {

    organization = "mtc-tf-jwson"

    workspaces {
      name = "terraform-aws-ecs"
    }
  }
}