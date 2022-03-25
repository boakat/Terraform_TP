#déclaration de ma première variable

variable "instancetype" {
  type        = string
  description = "set aws instance type"
  default     = "t2.nano"
}


#déclaration de ma deuxième varaible

variable "aws_common_tag" {
  type        = map
  description = "set aws tag"
  default = {
    Name = "ec2-boidi"
  }
}
