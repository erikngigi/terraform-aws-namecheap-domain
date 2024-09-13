# Terraform Module: Namecheap Domain with AWS Route 53 Hosted Zone

## Overview

This Terraform module manages a domain registered with Namecheap, using AWS Route 53 to create and manage DNS records. The module configures a hosted zone in AWS Route 53 and links the Namecheap domain's DNS settings to Route 53 for easy DNS management and automation.

## Features

- Creates an AWS Route 53 hosted zone for the domain.
- Configures DNS records, such as A, CNAME, MX, and TXT, based on input variables.
- Links Namecheap's DNS settings to the AWS Route 53 name servers.
- Supports both root domains and subdomains.
  
## Requirements

- [Terraform](https://www.terraform.io/downloads.html) v1.0 or higher
- AWS account with Route 53 permissions
- A domain registered on [Namecheap](https://www.namecheap.com/)
- Namecheap API key and username for DNS management

## Usage

1. Add the module to your Terraform configuration:

```hcl
module "namecheap_domain" {
  source = "path-to-your-module"

  domain_name          = "example.com"
  subdomain_name       = "sub.example.com"        # Optional
  aws_profile          = "your-aws-profile"       # AWS CLI profile
  aws_region           = "us-east-1"              # AWS region
  namecheap_api_key    = "your-namecheap-api-key"
  namecheap_username   = "your-namecheap-username"
  route53_zone_id      = "Z1XXXXXXX"              # If you have an existing hosted zone
  enable_dns_records   = true                     # Enable DNS records in Route 53
}
```

2. Apply the Terraform configuration:

```bash
terraform init
terraform apply
```

3. Once applied, the module will:
   - Create or use the specified AWS Route 53 hosted zone.
   - Add DNS records to Route 53 based on the input configuration.
   - Output the AWS name servers required for Namecheap configuration.

4. Update the Namecheap domain’s DNS settings:
   - Log in to your Namecheap account.
   - Navigate to the domain's DNS settings.
   - Update the name servers with the values provided in the module output.

## Inputs

| Name                  | Description                                                  | Type     | Default | Required |
|-----------------------|--------------------------------------------------------------|----------|---------|----------|
| `domain_name`          | The fully qualified domain name (e.g., `example.com`)         | `string` | n/a     | yes      |
| `route53_zone_id`      | Existing Route 53 hosted zone ID (optional)                  | `string` | `""`    | no       |

## Outputs

| Name               | Description                                      |
|--------------------|--------------------------------------------------|
| `route53_name_servers` | List of AWS Route 53 name servers to configure in Namecheap |
| `route53_zone_id`   | The Route 53 hosted zone ID for the domain       |


## Important Notes

- Ensure that your AWS account has the necessary permissions to manage Route 53 hosted zones and DNS records.
- Namecheap's API must be enabled for your account to use the API key.
- Name servers typically take 24 to 48 hours to propagate after updating them in Namecheap.
  
## License

This module is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contributing

Feel free to open issues or submit pull requests to improve the module or add new features.

---

This README is designed to be easy to understand, while covering all necessary details about configuring and managing the domain using AWS Route 53 with Namecheap. Let me know if you need any adjustments!
