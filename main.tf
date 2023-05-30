resource "aws_instance" "instance" {
  ami                    = "ami-01107263728f3bef4"  # Replace with your desired AMI ID
  instance_type          = "t2.micro"               # Replace with your desired instance type
  key_name               = "terraform"              # Replace with your key pair name
  user_data              = var.ec2_user_data        # Remove the quotation marks around var.ec2_user_data
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
}


resource "aws_security_group" "jenkins_security_group" {
  name        = "JenkinsSecurityGroup"
  description = "Security group for Jenkins"
  vpc_id      = var.vpc

  ingress {
    description = "Allow ssh from my public ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your IP address
  }

  ingress {
    description = "allow access to jenkins server"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JenkinsSecurityGroup"
  }
}

resource "aws_s3_bucket" "jenkins_artifacts_bucket" {
  bucket        = "jenkins-tabares1-bucket-name" # Replace with your desired bucket name
  acl           = "private"
  force_destroy = true

  tags = {
    Name = "JenkinsArtifactsBucket"
  }
}