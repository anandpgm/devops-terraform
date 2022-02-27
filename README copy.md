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

## Running Terragrunt with Codeway



### Destroying resources via pipeline
