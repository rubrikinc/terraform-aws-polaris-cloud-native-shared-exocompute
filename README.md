# Terraform Module - AWS Rubrik Cloud Native Shared Exocompute

This module configures an AWS account in Rubrik Security Cloud to use the Exocompute from another account.

## Prerequisites

There are a few services you'll need in order to get this project off the ground:

- [Terraform](https://www.terraform.io/downloads.html) v1.5.6 or greater
- [Rubrik Polaris Provider for Terraform](https://github.com/rubrikinc/terraform-provider-polaris) - provides Terraform functions for Rubrik Security Cloud (Polaris)
- [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) - Needed for Terraform to authenticate with AWS

## Usage

```hcl
# Configuring shared Exocompute using manually provided variables.

module "polaris-aws-cloud-native-shared-exocompute" {
  source  = "rubrikinc/polaris-cloud-native-shared-exocompute/aws"
  
  rsc_aws_cnp_account_id              = "01234567-89ab-cdef-0123-456789abcdef"
  rsc_aws_exocompute_host_account_id  = "fedcba98-7654-3210-fedc-ba9876543210"
  rsc_credentials                     = "../.creds/customer-service-account.json"
}
```

```hcl
# Deploy Exocompute configuration with inputs provided by the polaris-aws-cloud-native module.

module "polaris-aws-cloud-native_exocompute_host" {
  source  = "rubrikinc/polaris-cloud-native/aws"
  
  aws_account_name                    = "my_aws_account_hosted_exocompute"
  aws_account_id                      = "123456789012"
  aws_regions                         = ["us-west-2","us-east-1"]
  rsc_credentials                     = "../.creds/customer-service-account.json"
  rsc_aws_features                    = [
                                          "CLOUD_NATIVE_PROTECTION",
                                          "RDS_PROTECTION",
                                          "CLOUD_NATIVE_S3_PROTECTION",
                                          "EXOCOMPUTE",
                                          "CLOUD_NATIVE_ARCHIVAL"
                                        ]
}

module "polaris-aws-cloud-native_exocompute_shared" {
  source  = "rubrikinc/polaris-cloud-native/aws"
  
  aws_account_name                    = "my_aws_account_hosted_exocompute"
  aws_account_id                      = "098765432109"
  aws_regions                         = ["us-west-2","us-east-1"]
  rsc_credentials                     = "../.creds/customer-service-account.json"
  rsc_aws_features                    = [
                                          "CLOUD_NATIVE_PROTECTION",
                                          "RDS_PROTECTION",
                                          "CLOUD_NATIVE_S3_PROTECTION",
                                          "EXOCOMPUTE",
                                          "CLOUD_NATIVE_ARCHIVAL"
                                        ]
}

module "polaris-aws-cloud-native-customer-managed-exocompute-us-west-2" {
  source  = "rubrikinc/polaris-cloud-native-customer-managed-exocompute/aws"
  
  aws_exocompute_public_subnet_cidr   = "172.20.0.0/24"
  aws_exocompute_subnet_1_cidr        = "172.20.1.0/24"
  aws_exocompute_subnet_2_cidr        = "172.20.2.0/24"
  aws_exocompute_vpc_cidr             = "172.20.0.0/16"
  aws_eks_worker_node_role_arn        = module.polaris-aws-cloud-native.aws_eks_worker_node_role_arn
  aws_iam_cross_account_role_arn      = module.polaris-aws-cloud-native.aws_iam_cross_account_role_arn
  cluster_master_role_arn             = module.polaris-aws-cloud-native.cluster_master_role_arn
  rsc_aws_cnp_account_id              = module.polaris-aws-cloud-native.rsc_aws_cnp_account_id
  rsc_credentials                     = "../.creds/customer-service-account.json"
  rsc_exocompute_region               = "us-west-2"
  worker_instance_profile             = module.polaris-aws-cloud-native.worker_instance_profile
}

module "polaris-aws-cloud-native-customer-managed-exocompute-us-east-1" {
  source  = "rubrikinc/polaris-cloud-native-customer-managed-exocompute/aws"
  
  aws_exocompute_public_subnet_cidr   = "172.20.0.0/24"
  aws_exocompute_subnet_1_cidr        = "172.20.1.0/24"
  aws_exocompute_subnet_2_cidr        = "172.20.2.0/24"
  aws_exocompute_vpc_cidr             = "172.20.0.0/16"
  aws_eks_worker_node_role_arn        = module.polaris-aws-cloud-native.aws_eks_worker_node_role_arn
  aws_iam_cross_account_role_arn      = module.polaris-aws-cloud-native.aws_iam_cross_account_role_arn
  cluster_master_role_arn             = module.polaris-aws-cloud-native.cluster_master_role_arn
  rsc_aws_cnp_account_id              = module.polaris-aws-cloud-native.rsc_aws_cnp_account_id
  rsc_credentials                     = "../.creds/customer-service-account.json"
  rsc_exocompute_region               = "us-east-1"
  worker_instance_profile             = module.polaris-aws-cloud-native.worker_instance_profile
}

module "polaris-aws-cloud-native-shared-exocompute" {
  source  = "rubrikinc/polaris-cloud-native-shared-exocompute/aws"
  
  rsc_aws_cnp_account_id              = module.polaris-aws-cloud-native_host.rsc_aws_cnp_account_id
  rsc_aws_exocompute_host_account_id  = module.polaris-aws-cloud-native_shared.rsc_aws_cnp_account_id
  rsc_credentials                     = "../.creds/customer-service-account.json"
}

```

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.6 |
| <a name="requirement_polaris"></a> [polaris](#requirement\_polaris) | =0.8.0-beta.16 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_polaris"></a> [polaris](#provider\_polaris) | 0.8.0-beta.16 |

## Resources

| Name | Type |
|------|------|
| [polaris_aws_exocompute.shared](https://registry.terraform.io/providers/rubrikinc/polaris/0.8.0-beta.16/docs/resources/aws_exocompute) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rsc_aws_cnp_account_id"></a> [rsc\_aws\_cnp\_account\_id](#input\_rsc\_aws\_cnp\_account\_id) | Polaris account ID for the AWS account hosting Exocompute. | `string` | n/a | yes |
| <a name="input_rsc_aws_exocompute_host_account_id"></a> [rsc\_aws\_exocompute\_host\_account\_id](#input\_rsc\_aws\_exocompute\_host\_account\_id) | Rubrik Security Cloud account ID for the AWS account hosting Exocompute when "rsc\_aws\_exocompute\_type" is set to "Shared". | `string` | n/a | yes |
| <a name="input_rsc_credentials"></a> [rsc\_credentials](#input\_rsc\_credentials) | Path to the Rubrik Security Cloud service account file. | `string` | n/a | yes |

## Outputs

No outputs.


<!-- END_TF_DOCS -->