# important!!! DO NOT USE THIS FOR PRODUCTION ENVIRONMENTS, only temporary test environments. 
# The key pair created in this template is stored in the terraform state file unencrypted! 

provider "aws" {
  region = "us-east-1"
}

variable "key_pair_name" {
  type = string
  default  = "defaultkeypair"
}

resource "tls_private_key" "demo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#resource "aws_key_pair" "key_pair" {
#  key_name   = "keypairname"
#  public_key = tls_private_key.demo_key.public_key_openssh
#}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.demo_key.public_key_openssh
}

resource "local_file" "local_key_pair" {
  filename = "${var.key_pair_name}.pem"
  file_permission = "0400"
  content = tls_private_key.demo_key.private_key_pem
}


resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
  user_data = <<-EOF
    yum update #check if the system has the latest updates
    yum install cronie #install crontab
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    EOF
} 