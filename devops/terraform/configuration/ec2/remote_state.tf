terraform {
  # The configuration for this backend will be filled in by Terragrunt
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {
  }
}

# data "terraform_remote_state" "public_subnet" {
#   backend = "s3"
#   config {
#     bucket = "${var.remote_state_s3_bucket_name}"
#     key = "${var.remote_SG_state}"
#     region = "${var.aws_region}"
#   }
# }
