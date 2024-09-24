/* terraform block is used to configure some behaviors of Terraform
 itself, such as requiring a minimum Terraform version,providers,remote backend.
*/
terraform {
  required_version = "~>1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.26.0"
    }
  }
}