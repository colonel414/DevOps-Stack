provider "upcloud" {
  username = "my-username"
  password = "my-password"
}

locals {
  hostname_prefix = "k8s-"
  cluster_name    = "ronford-cluster"
#   ip_range = "10.0.0.0/16"
#   ip_prefix = cidrhost(split(":", ip_range)[0], split(":", ip_range)[1] - 1)
#   random_ip = cidrhost(ip_range, random_integer(split(":", ip_range)[1] - 2))
}

module "master" {
  source = "terraform-upcloud-modules/server/upcloud"

  hostname = "${local.hostname_prefix}master-${local.cluster_name}"
  zone     = "UK-LON1"
  plan     = "4xCPU-8GB"

  storage_devices = [
    {
      action = "clone"
      storage = "CentOS 8"
      title = "root"
    }
  ]

  network_interfaces = [
    {
      ip_address = "192.168.0.100"
    }
  ]

  user_data = <<-EOF
    #!/bin/bash
    sudo dnf install -y kubeadm
  EOF
}

module "worker" {
  source = "terraform-upcloud-modules/server/upcloud"

  hostname = "${local.hostname_prefix}worker-${local.cluster_name}"
  zone     = "UK-LON1"
  plan     = "4xCPU-8GB"

  storage_devices = [
    {
      action = "clone"
      storage = "CentOS 8"
      title = "root"
    }
  ]

  network_interfaces = [
    {
      ip_address = "192.168.0.101"
    },
    {
      ip_address = "192.168.0.102"
    }
  ]

  user_data = <<-EOF
  #!/bin/bash
  sudo dnf install -y kubeadm
  sudo useradd ronford
  sudo echo "ronford:newpassword" | sudo chpasswd
  sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
  sudo systemctl restart sshd
EOF

}
