# Indicate where to source the terraform module from.
# The URL used here is a shorthand for
# "tfr://registry.terraform.io/terraform-aws-modules/vpc/aws?version=5.8.1".
# Note the extra `/` after the protocol is required for the shorthand
# notation.
terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.8.1"
}

# Indicate what region to deploy the resources into
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "eu-west-1"
}
EOF
}

# Indicate the input values to use for the variables of the module.
inputs = {
  name = "eu-dev"
  cidr = "172.18.0.0/24"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
  public_subnets  = ["172.18.101.0/24", "172.18.102.0/24", "172.18.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    IAC = "true"
    Environment = "dev"
  }
}

