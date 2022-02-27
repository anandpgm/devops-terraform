terraform {
  source = "../../configuration//network"

  extra_arguments "common-variables" {
    arguments = [
      "-var-file=${get_terragrunt_dir()}/../../configuration/common.tfvars"
    ]
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cidr_block = "172.20.0.0/16"  // VPC CiDR Block
}