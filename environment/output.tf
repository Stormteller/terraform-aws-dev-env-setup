output "iam_ak" {
  value = "${module.service_iam.iam_access_key_id}"
}

output "iam_sk" {
  value = "${module.service_iam.iam_access_key_secret}"
}

# output "dev_domain" {
#   value = "${module.dev_subdomain.domain_name}"
# }

# output "staging_domain" {
#   value = "${module.staging_subdomain.domain_name}"
# }