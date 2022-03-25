#comment se connecter à Amazon
provider "aws" {
  region     = "us-east-1"
  access_key = "ton_acces_secret"
  secret_key = "ton_secret_key"

}

#resource "aws_instance" "terraform_demo"{
#  ami = "ami-0a634ae95e11c6f91"
#  instance_type = "t2.micro"
#  key_name = "devops-eric"
#}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instancetype
  key_name        = "devops-eric"
  tags            = var.aws_common_tag
  security_groups = ["${aws_security_group.allow_http_https.name}"]

  root_block_device {
    delete_on_termination = true
  }
}
#permet de ne pas être fdacturé lorsqu'on supprime la resource_model_source




resource "aws_security_group" "allow_http_https" {
  name        = "eric-sg"
  description = "Allow http and https inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#definir le nom Ip publique

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}
