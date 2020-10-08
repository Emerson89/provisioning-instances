module "ec2" {
  source = "../"
  
  name = "git by terraform"
  profile = "CustomProfile"
  ami = "ami-02e98f78"
  instance_type = "t2.micro"
  region = "us-east-1"
  key_name = "my-key"

  vpc_id = "vpc-id"  
  subnet_id = "subnet-id"

  ebs_block_device = [{
    device_name         = "/dev/sda1"
    volume_type         = "standard"
    volume_size         = 10
  }]
 
  tags = {
    Environment = "git by terraform"
  }
}