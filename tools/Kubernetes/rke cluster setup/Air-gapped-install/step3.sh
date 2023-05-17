#Install RKE
{
    https://rancher.com/docs/rke/latest/en/installation/
    curl -s https://api.github.com/repos/rancher/rke/releases/latest | grep download_url | grep amd64 | cut -d '"' -f 4 | wget -qi -
    chmod +x rke_linux-amd64
    sudo mv rke_linux-amd64 /usr/local/bin/rke
    rke --version

}

#Create an RKE Config File
{
    rke config
    #cluster.yml
    #Specify a private registry
}

#Run RKE
{
    rke up
}

#Save Your Files
{
    Save a copy of the following files in a secure location:
    -rancher-cluster.yml: The RKE cluster configuration file.
    -kube_config_cluster.yml: The Kubeconfig file for the cluster, this file contains credentials for full access to the cluster.
    -rancher-cluster.rkestate: The Kubernetes Cluster State file, this file contains the current state of the cluster including the RKE configuration and the certificates.
}
