# https://github.com/hashicorp/terraform/issues/13022#issuecomment-294262392  
# Command: `terraform init -backend-config="bucket=testim-okr-terraform-state-bucket" -backend-config="region=us-east-1"`


terraform {
  backend "s3" {
    key = "dev/state.tfstate"
    encrypt = true
  }
}

module "this_vpc" {
  source = "vpc"
  name = "${var.project_name}"
  cidr = "${var.vpc_cidr}"
  subnets_cidrs = "${var.vpc_subnets_cidrs}"
  aws_region = "${var.aws_region}"
}


module "service_iam" {
  source = "iam"
  username = "${var.project_name}-service-user"
}

module "dev_bucket" {
  source = "s3" 
  user_arn = "${module.service_iam.iam_user_arn}"
  bucket_name = "${var.project_name}-dev-bucket"
  aws_region = "${var.aws_region}"
}

module "staging_bucket" {
  source = "s3"
  user_arn = "${module.service_iam.iam_user_arn}"
  bucket_name = "${var.project_name}-staging-bucket"
  aws_region = "${var.aws_region}"
}
