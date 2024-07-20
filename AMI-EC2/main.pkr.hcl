# packer plugin for AWS
packer {
  required_plugins {
    amazon = {
      version = " >= 1.3.0 "
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# which ami to use as the based and where to save it
source "amazon-ebs" "ec2_instance_ami" {
  region             = "ap-southeast-2"
  instance_type      = "t2.micro"
  ami_name           = "ec2-instance-ami-${formatdate("YYYY-MM-DD-hh-mm", timestamp())}"
  source_ami         = "ami-0e98b1c81b916e2fa"
  ssh_username       = "ec2-user"
  security_group_ids = ["sg-07e577f4b14868291"]
  # ami_users = ["AWS_Account_ID"]
  ami_regions = ["ap-southeast-2"]
}

# build process
build {
  name = "ec2_instance_ami"
  sources = [
    "source.amazon-ebs.ec2_instance_ami"
  ]

  provisioner "file" {
    source      = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "shell" {
    inline = [
      "sudo chmod +x /tmp/provisioner.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "/tmp/provisioner.sh"
    ]
  }
}