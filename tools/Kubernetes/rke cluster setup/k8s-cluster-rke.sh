### Linux ###
kubectl
{   

    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    kubectl version --client
}
rke
{
    curl -s https://api.github.com/repos/rancher/rke/releases/latest | grep download_url | grep amd64 | cut -d '"' -f 4 | wget -qi -
    chmod +x rke_linux-amd64
    sudo mv rke_linux-amd64 /usr/local/bin/rke
    rke --version
}
helm
{
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
}
update system
{
    sudo apt-get update
    sudo apt-get upgrade
    sudo reboot
}
create rke user
#create user manually on all hosts
{
    sudo useradd -m rke
    sudo passwd rke
    sudo usermod -s /bin/bash rke
}
{#Enable passwordless sudo for the user:
    sudo nano /etc/sudoers.d/rke
    rke  ALL=(ALL:ALL) NOPASSWD: ALL
    usermod -aG wheel mentor
    passwd --lock root
    cd /home/mentor/.ssh
    cp /root/.ssh/authorized_keys authorized_keys
    chmod 0700 .ssh
    chmod 0600 .ssh/authorized_keys
    chown --recursive mentor:mentor .ssh
    nano /etc/ssh/sshd_config
    systemctl restart sshd
    systemctl status firewalld
}
 {   #Copy your ssh public key to the user’s ~/.ssh/authorized_keys file.
for i in rke-master-01 rke-master-02 rke-master-03 rke-worker-01 rke-worker-02; do
  ssh-copy-id rke@$i
done
 }
{#Confirm you can login from your workstation
    ssh $user$@ip-address
}
{
    #Enable required kernel modules:
    for module in br_netfilter ip6_udp_tunnel ip_set ip_set_hash_ip ip_set_hash_net iptable_filter iptable_nat iptable_mangle iptable_raw nf_conntrack_netlink nf_conntrack nf_conntrack_ipv4   nf_defrag_ipv4 nf_nat nf_nat_ipv4 nf_nat_masquerade_ipv4 udp_tunnel veth vxlan x_tables xt_addrtype xt_conntrack xt_comment xt_mark xt_multiport xt_nat xt_recent xt_set  xt_statistic xt_tcpudp;
     do
     sudo modprobe $module
       if ! lsmod | grep -q $module; then
         echo "module $module is not present";
       fi;
done
}
{ 
    #Step 4: Disable swap and Modify sysctl entries
    #SWAP
sudo nano /etc/fstab
# Add comment to swap line

sudo swapoff -a

#SYSCTL
sudo tee -a /etc/sysctl.d/99-kubernetes.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system

#Confirm is disabled
free -h
}
{
    #Step 5: Install Supported version of Docker
    #CentOS
    {
      sudo yum install -y yum-utils
      sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
      sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
      sudo systemctl enable docker
      sudo systemctl start docker
      sudo docker run hello-world
      sudo systemctl status docker
    }
    #Ubuntu
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce
sudo systemctl status docker
sudo docker version --format '{{.Server.Version}}'
#Add user to docker group
sudo usermod -aG docker rke
id rke
}
{
    #Step 6: Open Ports on firewall
    #Firewalld TCP and UDP ports:
       for i in 22 80 443 179 5473 6443 8472 2376 8472 2379-2380 9099 10250 10251 10252 10254 30000-32767; do
        sudo firewall-cmd --add-port=${i}/tcp --permanent
    done
    for i in 8285 8472 4789 30000-32767; do
        sudo firewall-cmd --add-port=${i}/udp --permanent
    done
    sudo firewall-cmd --reload      
    systemctl status firewalld
}
{
    #Step 6: Allow SSH TCP Forwarding
        sudo nano /etc/ssh/sshd_config
        AllowTcpForwarding yes
        sudo systemctl restart sshd
}
{
    #Step 7: Generate RKE cluster configuration file.
        rke config --name cluster.yml
}
{        #sample:
# https://rancher.com/docs/rke/latest/en/config-options/
nodes:
- address: 10.10.1.10
  internal_address:
  hostname_override: rke-master-01
  role: [controlplane, etcd]
  user: rke
- address: 10.10.1.11
  internal_address:
  hostname_override: rke-master-02
  role: [controlplane, etcd]
  user: rke
- address: 10.10.1.12
  internal_address:
  hostname_override: rke-master-03
  role: [controlplane, etcd]
  user: rke
- address: 10.10.1.13
  internal_address:
  hostname_override: rke-worker-01
  role: [worker]
  user: rke
- address: 10.10.1.114
  internal_address:
  hostname_override: rke-worker-02
  role: [worker]
  user: rke

# using a local ssh agent 
# Using SSH private key with a passphrase - eval `ssh-agent -s` && ssh-add
ssh_agent_auth: true

#  SSH key that access all hosts in your cluster
ssh_key_path: ~/.ssh/id_rsa

# By default, the name of your cluster will be local
# Set different Cluster name
cluster_name: rke

# Fail for Docker version not supported by Kubernetes
ignore_docker_version: false

# prefix_path: /opt/custom_path

# Set kubernetes version to install: https://rancher.com/docs/rke/latest/en/upgrades/#listing-supported-kubernetes-versions
# Check with -> rke config --list-version --all
kubernetes_version:
# Etcd snapshots
services:
  etcd:
    backup_config:
      interval_hours: 12
      retention: 6
    snapshot: true
    creation: 6h
    retention: 24h

kube-api:
  # IP range for any services created on Kubernetes
  #  This must match the service_cluster_ip_range in kube-controller
  service_cluster_ip_range: 10.43.0.0/16
  # Expose a different port range for NodePort services
  service_node_port_range: 30000-32767
  pod_security_policy: false


kube-controller:
  # CIDR pool used to assign IP addresses to pods in the cluster
  cluster_cidr: 10.42.0.0/16
  # IP range for any services created on Kubernetes
  # # This must match the service_cluster_ip_range in kube-api
  service_cluster_ip_range: 10.43.0.0/16
  
kubelet:
  # Base domain for the cluster
  cluster_domain: cluster.local
  # IP address for the DNS service endpoint
  cluster_dns_server: 10.43.0.10
  # Fail if swap is on
  fail_swap_on: false
  # Set max pods to 150 instead of default 110
  extra_args:
    max-pods: 150

# Configure  network plug-ins 
# KE provides the following network plug-ins that are deployed as add-ons: flannel, calico, weave, and canal
# After you launch the cluster, you cannot change your network provider.
# Setting the network plug-in
network:
    plugin: canal
    options:
      canal_flannel_backend_type: vxlan

# Specify DNS provider (coredns or kube-dns)
dns:
  provider: coredns

# Currently, only authentication strategy supported is x509.
# You can optionally create additional SANs (hostnames or IPs) to
# add to the API server PKI certificate.
# This is useful if you want to use a load balancer for the
# control plane servers.
authentication:
  strategy: x509
  sans:
    - "k8s.computingforgeeks.com"

# Set Authorization mechanism
authorization:
    # Use `mode: none` to disable authorization
    mode: rbac

# Currently only nginx ingress provider is supported.
# To disable ingress controller, set `provider: none`
# `node_selector` controls ingress placement and is optional
ingress:
  provider: nginx
  options:
     use-forwarded-headers: "true"
}
{
    #Step 7: Deploy Kubernetes Cluster with RKE
    rke up #or

    rke up --config ./rancher_cluster.yml

}
{
    #Step 8: Accessing your Kubernetes cluster
    export KUBECONFIG=./kube_config_cluster.yml
    kubectl get nodes
}