variable "rsc_credentials" {
  type        = string
  description = "Path to the Rubrik Security Cloud service account file."
}

variable "rsc_aws_cnp_account_id" {
  type        = string
  description = "Polaris account ID for the AWS account hosting Exocompute."  
}

variable "rsc_aws_exocompute_host_account_id" {
  type        = string
  description = "Rubrik Security Cloud account ID for the AWS account hosting Exocompute when \"rsc_aws_exocompute_type\" is set to \"Shared\"."
}