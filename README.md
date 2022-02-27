## How is the code in this repo organized?

The code in this repo uses the following folder hierarchy:

```
. 
├── README.md
├── devops ( Folder for devops codes )
    │
    └── terraform
        │
        ├── configuration
        │    │
        │    │── resource 1            
        │    │    └── main.tf 
        │    │    └── remote_state.tf
        │    │    └── variables.tf
        │    │    └── output.tf 
        │    │── resource 2            
        │    │    └── main.tf 
        │    │    └── remote_state.tf
        │    │    └── variables.tf
        │    │    └── output.tf  
        │    │── resource n            
        │    │    └── main.tf 
        │    │    └── remote_state.tf
        │    │    └── variables.tf
        │    │    └── output.tf                                    
        └── environment (e.g.: dev)
            │
            ├── resource 1
            │   └── terragrunt.hcl 
            │
            ├── resource 2
            │   └── terragrunt.hcl
            │
            └── resource n
               └── terragrunt.hcl

```

Where:
* **terragrunt.hcl**: Inside devops folder, there is a terragrunt.hcl. The terragrunt.hcl file is setup to 
  dynamically create S3 buckets for the terraform state with the following format `AWS Account Id`-`AWS Region`-eks-remote-state. 
  

* **Environment**: Within each region, there will be one or more "environments", such as `dev`, `staging`, `pro`, etc. Typically,
  an environment will correspond to a single [AWS Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/), which
  isolates that environment from everything else in that AWS account. There may also be a `_global` folder
  that defines resources that are available across all the environments in this AWS region, such as Route 53 A records,
  SNS topics, IAM Roles and ECR repos.

* **Resource**: Within each environment, you deploy all the resources for that environment, such as EC2 Instances, Auto
  Scaling Groups, ECS Clusters, Databases, Load Balancers, and so on. Note that the Terraform code for most of these
  resources lives in the [GitHub Enterprise Runway Organization](https://github.azc.ext.hp.com/runway).
  
## Resource Details and Tools used

This will create one VPC "172.20.0.0/16", a IGW,  NATGW, public subet "172.20.10.0/24", private subnet "172.20.20.0/24", a Ubuntu CICD instance in public subnet with Jenkins, Docker and Ansible installed and a private Ubuntu instance for deploy the application on port 80.

I have used Terragrunt by Gruntwork for DRY and maintainable Terraform code.
More details can be found at https://terragrunt.gruntwork.io/

Terraform version used  : Terraform v0.12.0
Terragrunt version used : Terragrunt v0.24.4

### Plan

Go to the `devops\terraform\global\network` folder and run `terragrunt init` followed by `terragrunt plan`
Go to the `devops\terraform\dev\cicd` folder and run `terragrunt init` followed by `terragrunt plan`
Go to the `devops\terraform\dev\private-ec2` folder and run `terragrunt init` followed by `terragrunt plan`


### Apply

Go to the `devops\terraform\global\network` folder and run `terragrunt init` followed by `terragrunt apply`
Go to the `devops\terraform\dev\cicd` folder and run `terragrunt init` followed by `terragrunt apply`
Go to the `devops\terraform\dev\private-ec2` folder and run `terragrunt init` followed by `terragrunt apply`

### Destroy

Go to the `devops\terraform\dev\cicd` folder and run `terragrunt init` followed by `terragrunt destroy`
Go to the `devops\terraform\dev\private-ec2` folder and run `terragrunt init` followed by `terragrunt destroy`
Go to the `devops\terraform\global\network` folder and run `terragrunt init` followed by `terragrunt destroy`

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.my_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_route_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.myvpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_instance.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_ingress_22](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_ingress_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_ingress_8080](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.subnet](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availablity Zone | `string` | `"us-west-2a"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-west-2"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VPC CIDR Block | `any` | n/a | yes |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | n/a | `string` | `"default"` | no |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | Private Subnet Range | `string` | `"172.20.20.0/24"` | no |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | Public Subnet Range | `string` | `"172.20.10.0/24"` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | AMI Id | `string` | `"ami-074251216af698218"` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to associate a public IP address with an instance in a VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | `"dev"` | no |
| <a name="input_ingress_22_cidr_blocks"></a> [ingress\_22\_cidr\_blocks](#input\_ingress\_22\_cidr\_blocks) | CIDR Range for SSH Port (22) | `list(string)` | n/a | yes |
| <a name="input_ingress_8080_cidr_blocks"></a> [ingress\_8080\_cidr\_blocks](#input\_ingress\_8080\_cidr\_blocks) | CIDR Range for Jenkins (8080)| `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_ingress_80_cidr_blocks"></a> [ingress\_80\_cidr\_blocks](#input\_ingress\_80\_cidr\_blocks) | CIDR Range for Application Port (80) | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Instance's Name | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance's Type | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key Pair Name | `any` | `null` | no |
| <a name="input_sg_ingress_8080_allow"></a> [sg\_ingress\_8080\_allow](#input\_sg\_ingress\_8080\_allow) | Enable port 8080 | `bool` | `false` | no |
| <a name="input_sg_ingress_80_allow"></a> [sg\_ingress\_80\_allow](#input\_sg\_ingress\_80\_allow) | Enable port 80 | `bool` | `false` | no |
| <a name="input_subnet_type"></a> [subnet\_type](#input\_subnet\_type) | Subnet type. private or public | `string` | `"private"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Custom user data script | `any` | `null` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_cidr"></a> [private\_subnet\_cidr](#output\_private\_subnet\_cidr) | Private Subnet ID |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | Private Subnet ID |
| <a name="output_public_subnet_cidr"></a> [public\_subnet\_cidr](#output\_public\_subnet\_cidr) | Public Subnet ID |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | Public Subnet ID |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID associated with VPC |
| <a name="output_id"></a> [id](#output\_id) | Instance's AMI Id |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Instance's Private IP Address. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Instance's Public IP |
<!-- END_TF_DOCS -->