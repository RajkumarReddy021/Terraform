variable "ami_maps" {
  type = map(string)
  default = {
    "Redhat" = "ami-04708942c263d8190"
    "Ubuntu" = "ami-03f4878755434977f"
    "Amazon" = "ami-0a0f1259dd1c90938"
  }
  description = "AMI Ids With OS Distributions"
}

variable "os_name" {
  type    = string
  default = "Redhat"
}

variable "availability_zone" {
  type    = string
  default = "ap-south-1a"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "comman_tags" {
  type = map(string)
  default = {
    "ManagedBy" = "IaC"
    "Team"      = "DevOps"
  }
}