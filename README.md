# DevOps Automation project
- Setup AWS-EKS-ECR use Terraform.
- Deploy Python simple app use Helm chart.
- Use FluxV2 to automate kuberenets deployment image update from ECR registtry.

## Required Packages

 - [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
 - [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
 - [eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)
 - [flux](https://fluxcd.io/flux/cmd/)

## Usage
- Deploy EKS Stack Use terraform
Edit ./terraform-eks-vpc-module/varibles.tf file to set your prefere values.
Example to use Gitlab-ci to deploy ( .gitlab-ci.yml and ./gitlab/infra.gitlab-ci.yml)
Terraform commands

```terraform
cd ./terraform-eks-vpc-module
terraform init 
terraform plan
terraform apply
```

# Note - Project not completed ...