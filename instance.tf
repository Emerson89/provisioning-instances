##The first step to using Terraform is typically to configure the provider(s) you want to use.
provider "aws" { 
	region = "us-east-1"
	shared_credentials_file = "~/.aws/credentials"
	profile = "LOGIN_USER_AWS"
}

resource "aws_instance" "git" {
	ami = "ami-02e98f78"
	instance_type = "t2.micro" 
	key_name = "${aws_key_pair.my-key.key_name}"
	security_groups = ["${aws_security_group.allow_sec.name}"]

	tags = {
	  Name = "git by Terraform"
	}
}
##On here each resource block describes one or more infrastructure objects
resource "aws_key_pair" "my-key" {
    ##Create key pair using ssh-keygen
        key_name = "my-key"
	public_key = "${file("~/.ssh/id_rsa.pub")}"
 }

resource "aws_security_group" "allow_sec" {
	name = "allow_sec"
	# SSH HTTP access 
	ingress { 
	   from_port = 22
	   to_port = 22
	   protocol = "tcp"
	   cidr_blocks = ["0.0.0.0/0"]
	   }
	egress {
	   from_port = 0
	   to_port = 0
	   protocol = "-1"
	   cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
	  Name = "SG git by Terraform"
	}
}
##Exit dns at the end of the process
output "git_public_dns" {
	value = "${aws_instance.git.public_dns}"
}
