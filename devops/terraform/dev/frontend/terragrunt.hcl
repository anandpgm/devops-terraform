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
  ami                     = "ami-074251216af698218"
  instance_type           = "t2.micro"
  instance_name           = "frontend"
  environment             = "dev"
  subnet_id               = "subnet-06db725899217ad89"
  ingress_22_cidr_blocks  = ["0.0.0.0/0"] 
  key_name                = "assignment"
  associate_public_ip_address = true
  user_data               = "${file("../../configuration/ec2/frontend_userdata.sh")}"

}