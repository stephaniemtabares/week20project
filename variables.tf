variable "vpc" {
  description = "Default VPC"
  type        = string
  default     = "vpc-0ff5d2898ab647dec"
}

variable "ami" {
  description = "AMI ID for the Jenkins server"
  type        = string
  default     = "ami-01107263728f3bef4"
}

variable "instance" {
  description = "Instance type for the Jenkins server"
  type        = string
  default     = "t2.micro"
}

variable "ec2_user_data" {
  description = "User data for the Jenkins server"
  default     = <<-EOF
    #!/bin/bash
    sudo yum update –y
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade
    sudo dnf install java-11-amazon-corretto -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    EOF
}