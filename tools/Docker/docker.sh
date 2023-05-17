{
    sudo yum remove docker-ce docker-ce-cli containerd.io docker-compose-plugin

    #sudo rm -rf /var/lib/docker
    #sudo rm -rf /var/lib/containerd
}

{
    sudo yum install -y yum-utils
    sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

{
    sudo systemctl enable docker --now
    sudo systemctl start docker
    sudo systemctl status docker
}
