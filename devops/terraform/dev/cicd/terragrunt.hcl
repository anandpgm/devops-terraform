terraform {
  source = "../../configuration//ec2"

  extra_arguments "common-variables" {
    arguments = [
      ]
    commands = get_terraform_commands_that_need_vars()
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  instance_type               = "t2.large" 
  instance_name               = "CICD-Instance" 
  subnet_type                 = "public"  
  ingress_22_cidr_blocks      = ["0.0.0.0/0"] 
  sg_ingress_8080_allow       = true 
  ingress_8080_cidr_blocks    = ["0.0.0.0/0"]
  key_name                    = "assignment"
  associate_public_ip_address = true
  user_data                   = "${file("../../configuration/ec2/cicd_userdata.sh")}"

}