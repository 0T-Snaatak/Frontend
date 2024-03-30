
// packer init .
// packer fmt .
// packer validate .
// packer build golden-ami.pkr.hcl


packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "frontend-app" {
  ami_name      = "frontend-app-v1"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "frontend-app-v1"
  sources = [
    "source.amazon-ebs.frontend-app"
  ]

  provisioner "shell" {

    inline = [
      "echo Installing Pre-requisites",
      // "sleep 30",
      "sudo apt update",
      // "echo Installing make...",
      // "sudo apt install -y make",
      "echo Installing npm..",
      "sudo apt install npm -y",
      "echo making dir",
      "mkdir /home/ubuntu/Frontend/",
    ]
  }

  provisioner "file" {
    destination = "/home/ubuntu/Frontend"
    source      = "/home/harshit/Frontend/"
  }

  provisioner "shell" {
    environment_vars = [
      "NODE_OPTIONS='--max-old-space-size=512'",
    ]
    inline = [
      "echo Building Frontend",
      // "sleep 30",
      "ls /home/ubuntu/Frontend/",
      "cd /home/ubuntu/Frontend/ && npm install",
      // "cd /home/ubuntu/Frontend/ && npm start",
      "sudo mv /home/ubuntu/Frontend/frontend.service /etc/systemd/system/",
      "sudo systemctl daemon-reload",
      "sudo systemctl start frontend.service",
      "sudo systemctl enable frontend.service",
      "sudo systemctl status frontend.service",
    ]
  }

}

