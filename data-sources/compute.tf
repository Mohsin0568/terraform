data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu_us_region" {
  most_recent = true
  owners      = ["099720109477"]
  provider    = aws.us-region

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ami_id_us_region" {
  value = data.aws_ami.ubuntu_us_region.id
}

output "current_user" {
  value = data.aws_caller_identity.current
}

output "current_region" {
  value = data.aws_region.current
}

resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}