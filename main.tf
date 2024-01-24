resource "polaris_aws_exocompute" "shared" {
  account_id      = var.rsc_aws_cnp_account_id
  host_account_id = var.rsc_aws_exocompute_host_account_id
}