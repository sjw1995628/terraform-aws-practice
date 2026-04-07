# terraform {
#   cloud {

#     organization = "mtc-tf-jwson"

#     workspaces {
#       name = "terraform-aws-ecs"
#     }
#   }
# }

terraform {
  backend "s3" {
    bucket       = ""
    key          = "terraform.tfstate"
    region       = "ap-northeast-2"
    use_lockfile = true
  }
}
