

# Terraform: automatically aws resource creation opensource tool /it can work with multiple cloud paltforms 
1. uses its own language 
2. iac : infrastrucutre as a code 
3. code will be in user friendly manner  
 
## Download terraform from internet. 
	move to /usr/bin to work anywhere in the machine. 
terraform.io/downloads 
https://github.com/sreenidevopsgroup9/Terraform/
registry.terraform.io 
developers.hashicorp.com/terraform.
---

### terraform init : used to install the plugins for terraform. 
### terraform validate :  to check syntax. 
### terraform apply :  
### terraform plan : to review your code & what will be provision by  this code. 
### terraform destroy : to delete the instance. 
### aws ec2 list instances | grep -i list 
### terraform destroy -auto-approve : it will not ask permissions for destroying. 
### terraform apply -auto-approve -var instance_type=t2.large : to specify the instance type. 
### terraform output : to know the created resource deatils mentioned .tf file. 
### terraform import aws_instance.import_resource <instance_id> : to import the instance. 

---

## Input variables: 
	string, number, list, map, boolean. 
	
## output variables : is used to output the variables of aws resources created from terraform or outsode terraform.
	
	output "ami_id" {
		value = aws_instance.instance_name.id
	}

injection of keys from outside: 

	export AWS_ACCESS_KEY_ID="AKIAWPLY3EBZJRRQ2INT"
	export AWS_SECRET_ACCESS_KEY_ID="086wWuOMIVB0hdhR1n5nNO4OUV4phJZIUzQiYuns"
	export AWS_REGION="ap-south-1"

env | grep -i aws : to know the aws secret keys.

Parameters in the configuration:
	access_key  = var.access_key
	secret_key = var.secret_key
	region = var.region
===============================================
 

 ``` Create a configuration file with .tf  to work with terraform in a local machine.

	configure.tf:
		

        provider "aws" {

                access_key=var.access_key
                secret_key=var.secret_key
                region=var.region
				
				access_key="AKIAWPLY3EBZJRRQ2INT"
				secret_key="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"
				region="ap-south-1"
				
        }
        resource "aws_instance" "first_instance"{
                ami = "ami-0a7cf821b91bcccbc"
				availability_zone = "ap-south-1a"
                instance_type = "t2.micro"
				subnet_id     = "subnet-076dd59a1a97fb239"
                key_name = "key-01"
                vpc_security_group_ids = ["sg-08917e8e26e1bf785"]
                tags = {
                        Name = "first_instance"
                        Department = "devops"
                        tools = "Terraform"
                }

        }
        variable "access_key" {}
        variable "secret_key" {}
        variable "region" {}
		```
---
## Provider block for providing access_key,sec keys will be taken from env variables 
	ex:- file.tf (it will take access keys from env). 
	
### Vpc creation: 
	
	```
	resource "aws_vpc" {
		cidr_block = "10.10.0.0/16"
		tags = {
			Name = "vpc-1"
			department = "devops"
			tool = "terraform"
		}
	}
	
	resource "aws_subnet" "subnet-01" {
		vpc_id = aws_vpc.vpc-1.id
		cidr_block = "10.10.0.0/24"
		tags = {
			Name = "subnet-01"
			department = "devops"
			tool = "terraform"
		}
	}

	resource "aws_subnet" "subnet-02" {
		vpc_id = aws_vpc.vpc-1.id
		cidr_block = "10.10.1.0/24"
		tags = {
			Name = "subnet-01"
			department = "devops"
			tool = "terraform"
		}
	}
	
	resource "aws_internet_gateway" "first_igw" {
		vpc-id = "vpc_id = aws_vpc.vpc-1.id"
		tags = {
			Name = "first_igw"
			department = "devops"
			tool = "terraform"
		}
		
	}
	resource "aws_route_table" "first_public_rtb" {															
		vpc_id = "vpc_id = aws_vpc.vpc-1.id"
		routes = {
			cidr_block = "0.0.0.0/0"
			gateway_id = aws_internet_gateway.first_igw.id
		}
		tags = {
			Name = "first_pubilc_rtb"
			department = "devops"
			tool = "terraform"
		}
	}
	
	resource "aws_route_table_association"" "first_public_rtb_assoc" {															
		subnet_id = aws_subnet.subnet-01.id
		route_table_is =  aws_route_table.first_public_rtb.id
		tags = {
			Name = "first_pubilc_rtb"
			department = "devops"
			tool = "terraform"
		}
	}
	```
---
```
resource "aws_vpc" "vpc_1" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name       = "vpc-1"
    department = "devops"
    tool       = "terraform"
  }
}

resource "aws_subnet" "subnet_01" {
  vpc_id     = aws_vpc.vpc_1.id
  cidr_block = "10.10.0.0/24"
  tags = {
    Name       = "subnet-01"
    department = "devops"
    tool       = "terraform"
  }
}

resource "aws_subnet" "subnet_02" {
  vpc_id     = aws_vpc.vpc_1.id
  cidr_block = "10.10.1.0/24"
  tags = {
    Name       = "subnet-02"
    department = "devops"
    tool       = "terraform"
  }
}

resource "aws_internet_gateway" "first_igw" {
  vpc_id = aws_vpc.vpc_1.id
  tags = {
    Name       = "first_igw"
    department = "devops"
    tool       = "terraform"
  }
}

resource "aws_route_table" "first_public_rtb" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.first_igw.id
  }

  tags = {
    Name       = "first_public_rtb"
    department = "devops"
    tool       = "terraform"
  }
}

resource "aws_route_table_association"" "first_public_rtb" {															
		subnet_id = aws_subnet.subnet-01.id
		route_table_is =  aws_route_table.first_public_rtb.id
		tags = {
			Name = "first_pubilc_rtb"
			department = "devops"
			tool = "terraform"
		}
	}
	```
---


 ## file_name.tf : create a file with this extension. 
 
 
 ```
	resource "aws_instance" "machine-1" {
		subnet_id = "aws_subnet.subnet-01.id
		ami = "var.ami"
		key_name = "var.key_name"
		instance_type = "var.instance_type"
		count = "1"
		associate_public_ip_address = "var.associate_public_ip_address"
		tags = {
			Name = "machine-1"
			department = "devops"
			tool = "terraform"
		}
		
	}
	
 Create another file to provide variable values for above resource.
 
	variable "ami" {}
	variable "instance_type" {} 
	variable "key_name" {}
	variable "associate_public_ip_address" {}
	 
	on the fly we can pass these values while creating a resource.
	
	
	variable "ami" {
		type = string
		default = "adfd-00dhdudis"
	}
	variable "instance_type" {
		type = "string
		default = "t2.micro"
	} 
	variable "key_name" {}
	variable "associate_public_ip_address" {}
	
	```	
---
```
	variable "ami" {
		type = string 
		default = ""
	}
	
	variable "ami" {
		type = list 
		default = ["aami_id","ami_id"]
	}

	resource "aws_instance" "machine-1" {
		subnet_id = "aws_subnet.subnet-01.id
		ami = var.ami[1]

	variable "ami" {
		type = map 
		default = ({
		ubuntu20 = ubuntu20 = "aami_id"
				   ubuntu22 = "ami_id"
				})
	}
	variable "number_of_instances" {
		type = number
		default = 1
	}
	 
	resource "aws_instance" "machine-1" {
		subnet_id = "aws_subnet.subnet-01.id
		ami = var.ami["ubuntu20"]
		
```

---
```
	output "public_ip" {
		value = aws_instance.first_instance_one.public_ip
	}
	
	output "private_ip" {
		value = aws_instance.first_instance_one.private_ip
	}
	
	output "key_name" {
		value = var.key_name
	}
	
	output "instance_type" {
		value = var.instance_type
	}
	
	output "ami" {
		value = var.ami
	}		
```
---	

### Data sources  : is used to fetch the information from outside of the terraform resources. 
ex: if we create a instance manually in aws.

```
	data "aws_instance" "fetch-one" {
		instance_id = "Id"
	}
	
	output "public_ip" } {
		value = data.aws_instance.fetch-one.public_ip
	}
	output "private_ip" } {
		value = data.aws_instance.fetch-one.private_ip
	}

	output "key_name" } {
		value = data.aws_instance.fetch-one.key_name 
	}
	```
---
## Backend: used to backup a terraform.tfstate file to cloud

#### backend.tf:
```
terraform {
	backend "s3" {
		bucket = "for--terraform"
		key = "terraform.tfstate"
		region = "ap-south-1"
	}
}
```
 ``` vpc.tf: 


resource "aws_vpc" "vpc-001" {
	cidr_block = "22.22.0.0/16"
	tags = {
		Name="backend_vpc"
		deaprtment="devops"
		tools="terraform"
		}
} 
```
---

### Modules: are reusable method 
	using modules block we can reuse the existing code. 
	use terraform in another project: 
```
vpc.tf : 
resource "aws_vpc" "pvc_01" {
	cidr_block = var.cidr_block
	tags = {
		Name = var.Name
		department = var.department
		tool = var.tool
	}
	}
	```
	
``` var.tf:
variable "cidr_block" {}
variable "Name" 
variable "department" {}

output.tf:
output "cidr_block" {
	value = var.cidr_block
}
output "department" {
	value = var.var.department
}

```

``` s3.tf:
resource "aws_s3_bucket" "module_s3" {
	bucket = var.bucket_name
	tags = {
		Name = var.bucket_name
		department = var.department
		tool = var.tool
	}
}
```
---

## var.tf file to provide the values for variables.

``` module.tf:

module "vpc" {
	source="/home/ubuntu/terraform/modules/vpc"
	cidr_block="11.11.0.0/16"
	Name= "flipkart-vpc"
	department="devops"
	tool="terraform"
	 }
module "s3" {
	source = "/home/ubuntu/terraform/modules/s3"
	bucket_name = "flikart_bucket-001"
	Name = "flipkart-bucket"
	department  = "devops"
	tool = "terraform"
}
```

---

#### null_resource: 

``` resource  "aws_vpc" "null_vpc"{
	cidr_block = "16.16.0.0/16"
	tags = {
		Name = "null_vpc"
	}
	}
resource "aws_instance" "instance_creation" {
	instance_type = "t2.micro"
	key_name = "key-01"
	subnet_id     = "subnet-076dd59a1a97fb239"
	vpc_security_group_ids = ["sg-08917e8e26e1bf785"]
	ami = "ami-03f4878755434977f"
	tags = {
		Name = "remote-exec"
	}
}
	
	output "vpc_id"{
		value = aws_vpc.null_vpc.id
	}
	output "vpc_cidr_block"{
		value = aws_vpc.null_vpc.cidr_block
	}
	
	resource "null_resource" "null-exec" {
		depends_on = [aws_vpc.null_vpc]
		provisioner "local-exec" {
		command = "terraform output >>abc.txt"
		}
	}
	
	
	resource "null_resource" "remote_execution" {
		connection {
			type = "ssh"
			user = "ubuntu"
			private_key = file("/home/ubuntu/pemkey")
			host =  aws_instance.instance_creation.public_ip
		}
	
	
		provisioner "remote-exec" {
	
		inline = [
			"sudo apt-get update -y",
			"sudo apt-get install nginx -y",
			"sudo /etc/init.d/nginx start"
		]
	}
	}
	```
---
### null-Resource : 
```
provider "aws" {}
resource  "aws_vpc" "null_vpc"{
        cidr_block = "16.16.0.0/16"
        tags = {
                Name = "null_vpc"
        }
        }

        output "vpc_id"{
                value = aws_vpc.null_vpc.id
        }
        output "vpc_cidr_block"{
                value = aws_vpc.null_vpc.cidr_block
        }
        resource "null_resource" "null-exec" {
                depends_on = [aws_vpc.null_vpc]
                provisioner "local-exec" {
                command = "terraform output >> abc.txt"
                }
        }
```

#### import resource : used to import the resource created by cloud into the terraform file and then make changes to themachine with terraform.
	
```
resource "aws_instance" "import_resource" {
	
}
```		

