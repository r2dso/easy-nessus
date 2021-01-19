variable "ports_to_open" {
    type = list
    default = [443,22,8834]
}

variable "approved_key_name" {
  type = string
}

variable "approved_ips" {
  type = string
  default = "0.0.0.0/0"
}

resource "aws_security_group" "nessus_rules" {
  name        = "nessus_rules"
  description = "Ports Required for Nessus Vulnerability Scanner"

dynamic "ingress" {
  for_each = [for p in var.ports_to_open: {
    description = "${p} Opened for Nessus"
    to_port     = p
  }]

  content {
      description = ingress.value.description
      to_port = ingress.value.to_port
      from_port = 0
      protocol    = "tcp"
      cidr_blocks = [var.approved_ips]
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nessus_rules"
  }
}

resource "aws_instance" "nessus_server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = data.aws_ec2_instance_type_offering.low_cost.instance_type
    key_name = var.approved_key_name
    security_groups = ["nessus_rules"]
    tags = {
        Name = "nessus_server"
    }

}