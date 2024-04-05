
// packer init .
// packer fmt .
// packer validate .
// packer build golden-ami.pkr.hcl
// packer build \
//   -var "weekday=Sunday" \
//   -var "flavor=chocolate" \
//   -var "sudo_password=hunter42" .
// packer build -on-error=ask golden-ami.pkr.hcl 2>&1 | tee packer.log
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
  // subnet_id = "subnet-12345678"
  // vpc_id = "vpc-12345678"
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
      "sudo apt-get update",
      "sudo apt-get install nodejs -y",
      "sudo apt-get install npm -y",
    ]
  }

  provisioner "file" {
    destination = "/home/ubuntu/"
    source      = "/home/harshit/Frontend"
  }

  provisioner "shell" {
    environment_vars = [
      "NODE_OPTIONS='--max-old-space-size=512'",
    ]
    inline = [
      "echo Building Frontend",
      "cd /home/ubuntu/Frontend/ && npm install",
      "echo Adding Frontend Service File",
      "sudo mv /home/ubuntu/Frontend/frontend.service /etc/systemd/system/",
      "sudo systemctl daemon-reload",
      // "sudo systemctl start frontend.service",
      // "sudo systemctl enable frontend.service",
      // "sudo systemctl status frontend.service",
    ]
  }

}

