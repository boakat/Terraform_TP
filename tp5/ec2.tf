#comment se connecter à Amazon
provider "aws" {
  region     = "us-east-1"
  access_key = "ton_acces_secret"
  secret_key = "ton_secret_key"

}

terraform{
  backend "s3" {
    bucket = "terraform-backend-boidi"
    key = "eric.tfstate"
    region = "us-east-1"
    access_key = "AKIATYX4SUNBMT3VOX6F"
    secret_key = "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"

  }
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

  #Installer le serveur nginx grâce à remote-exec

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

#faire la connexion ssh depuis ma machine terraform à AWS
    connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("./devops-eric.pem")
    host = self.public_ip
  }
}
  root_block_device {
   delete_on_termination = true
  }
}

#permet de ne pas être facturé lorsqu'on supprime la resource_model_source




resource "aws_security_group" "allow_http_https" {
  name        = "eric1-sg"
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
#connexion par ssh
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ouverture  du flux de sortant

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}


#definir le nom Ip publique

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true

provisioner "local-exec"{
    command = "echo PUBLIC IP: ${aws_eip.lb.public_ip} ; ID: ${aws_instance.myec2.id} ; AZ: ${aws_instance.myec2.availability_zone}; >> infos_ec2.txt"

 }
}
