#comment se connecter à Amazon
provider "aws" {
  region     = "us-east-1"
  access_key = "ton_acces_secret"
  secret_key = "ton_secret_key"

}
resource "aws_instance" "myEC2" {
  ami           = "ami-07d02ee1eeb0c996c"
  instance_type = "t2.micro"
  key_name      = "devops-eric"
  tags = {
    Name = "ec2-eric"
  }
    #permet de ne pas être facturé lorsqu'on supprime la resource_model_source

    root_block_device {
      delete_on_termination = true
    }

}
