terraform {
  source = "../../configuration//ec2"

  extra_arguments "common-variables" {
    arguments = [
      // "-var-file=${get_terragrunt_dir()}/../../configuration/common.tfvars"
    ]
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {

  instance_name               = "Private-Instance"
  subnet_type                 = "private"
  ingress_22_cidr_blocks      = ["172.20.0.0/16"]
  sg_ingress_80_allow         = true
  ingress_80_cidr_blocks      = ["172.20.0.0/16"]
  key_name                    = "assignment"
  user_data                   = "${file("../../configuration/ec2/backend_userdata.sh")}"

}