data "aws_ami" "ubuntu" { 
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  owners = ["099720109477"] # Canonical
}

data "aws_ec2_instance_type_offering" "low_cost" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
}