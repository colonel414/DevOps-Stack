#!/bin/bash

{
    sudo useradd -m $user
    sudo passwd $user
    sudo usermod -s /bin/bash $user
    usermod -aG wheel $user
}

{
    mkdir -p /home/$user/.ssh/
    cp /root/.ssh/authorized_keys /home/$user/.ssh/
}


{
    # Enable passwordless sudo for user
    # yum install nano
    echo "$user  ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/$user
    sudo chown -R $user /home/$user/.ssh
}

# {
#     # Copy ssh key from control to all hosts and confirm login
#     ssh-keygen -t rsa -b 4096

#     # ssh-copy-id root@[IP]

#     for i in 94.237.51.141  94.237.49.187 94.237.55.237  ; do
#         ssh-copy-id $user@$i
#     done
# }


{
    sed -i "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
    sed -i "s/.*PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
    # sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
    # sed -i "s/.*AuthorizedKeysFile.*/AuthorizedKeysFile\t\.ssh\/authorized_keys/g" /etc/ssh/sshd_config
    sudo systemctl restart sshd
}

#Storage setup
{
   # For RHEL, CentOS, and EKS with EKS Kubernetes Worker AMI with AmazonLinux2 image, use this command:
     sudo yum install iscsi-initiator-utils
}

{
    # start and enable iscsid.service
     sudo systemctl start iscsid && sudo systemctl enable iscsid
     sudo systemctl status iscsid
}

{
    sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
}

{
    sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
}

{
    sudo yum install docker-ce-20.10.23 docker-ce-cli-20.10.23 containerd.io docker-buildx-plugin docker-compose-plugin 
    curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    sudo systemctl enable --now docker
    sudo systemctl start docker
}

{
  ###Setup daemon.
  sudo mkdir -p /etc/docker
  cat >/etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-file": "5",
    "max-size": "50m"
  },
  "storage-driver": "overlay2",
  "storage-opts": ["overlay2.override_kernel_check=true"],
  "insecure-registries": ["127.0.0.1"]
}
EOF
}

{
  sudo systemctl restart docker
  sudo docker version --format '{{.Server.Version}}'
  sudo docker-compose -v
  sudo usermod -aG docker $user
  id $user
  newgrp docker
}

{
    # Update linux subsystem
    ### CentOS ###
    sudo yum -y update
        

    # Install nfs utils for Kubernetes NFS driver
    sudo yum -y install nfs-utils

    # load netfilter probe specifically
    lsmod
    modprobe br_netfilter
    # sudo reboot
}

# Enable required kernel modules
{
    for module in br_netfilter ip6_udp_tunnel ip_set ip_set_hash_ip ip_set_hash_net iptable_filter iptable_nat iptable_mangle iptable_raw nf_conntrack_netlink nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4 nf_nat_masquerade_ipv4 nfnetlink udp_tunnel veth vxlan x_tables xt_addrtype xt_conntrack xt_comment xt_mark xt_multiport xt_nat xt_recent xt_set xt_statistic xt_tcpudp; do
        if ! lsmod | grep -q $module; then
            echo "module $module is not present"
            sudo modprobe $module
        fi
    done
}

{
    sudo setenforce 0
    sudo getenforce
    sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux
    sudo cat /etc/selinux/config
    # reboot
}

{
    modprobe br_netfilter
    echo '1' >/proc/sys/net/bridge/bridge-nf-call-iptables
}

# Disable swap and Modify sysctl entries
{
    # sudo nano /etc/fstab
    # Add comment to swap line

    sudo swapoff -a
    sed -i '/swap/d' /etc/fstab
}

{
    sudo tee -a /etc/sysctl.d/k8s.conf <<EOF
    net.bridge.bridge-nf-call-ip6tables = 1
    net.bridge.bridge-nf-call-iptables = 1
    net.bridge.bridge-nf-call-arptables = 1
    net.ipv4.ip_forward                 = 1
    net.ipv4.conf.lxc*.rp_filter = 0
EOF

    sudo sysctl --system
}

{
    free -h
}
# Open Ports on firewall
{
    # TCP PORTS
    for i in 22 80 443 179 2379 2380 4240 5473 6443 8443 8472 2376 8472 9098 9099 2379-2380 9099 9345 10250 10251 10252 10254 10255 30000-32767; do
        sudo firewall-cmd --add-port=${i}/tcp --permanent
    done

    #UDP PORTS
    for i in 8285 8472 4789 30000-32767 51820 51821; do
        sudo firewall-cmd --add-port=${i}/udp --permanent
    done

    sudo firewall-cmd --reload
}

{
    # firewall-cmd --permanent --zone=trusted --change-interface=docker0
    sudo firewall-cmd --permanent --zone=trusted --add-port=4243/tcp
    sudo firewall-cmd --zone=public --add-masquerade --permanent
    sudo firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 4 -i docker0 -j ACCEPT
    sudo firewall-cmd --permanent --zone=docker --change-interface=docker0
    sudo systemctl enable firewalld
    sudo systemctl restart firewalld
    sudo firewall-cmd --reload
}

#Allow SSH TCP Forwarding
{
    sudo nano /etc/ssh/sshd_config
    #> AllowTcpForwarding yes
    #> Subsystem sftp internal-sftp

    sudo systemctl restart sshd
}

{
    sudo yum install iptables-services iptables-utils
    sudo systemctl start iptables
    sudo systemctl start ip6tables
    sudo systemctl enable iptables
    sudo systemctl enable ip6tables
    sudo systemctl status iptables
    sudo systemctl status ip6tables
    sudo systemctl restart docker
}
