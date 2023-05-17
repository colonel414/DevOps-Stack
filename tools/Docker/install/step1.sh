#https://computingforgeeks.com/how-to-install-docker-on-rhel-7-server-desktop/
#https://docs.docker.com/engine/install/rhel/
#https://computingforgeeks.com/

#Uninstall old versions
{
    sudo yum remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-engine \
        podman \
        runc \
        podman-buildah
}

#Install using repsitory
{
    #Setup repository
    sudo yum install -y yum-utils
    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/rhel/docker-ce.repo
}

{
    #Install docker engine
    sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

#To install a specific version
{
    yum list docker-ce --showduplicates | sort -r
    sudo yum install docker-ce- docker-compose-plugin <VERSION_STRING >docker-ce-cli- <VERSION_STRING >containerd.io
    sudo systemctl start docker
}

#Install from a package
#Go to https://download.docker.com/linux/rhel/ and choose your version of RHEL. Then browse to s390x/stable/Packages/ and download the .rpm file for the Docker version you want to install
{
    sudo yum install /path/to/package.rpm
    sudo systemctl start docker
    sudo docker run hello-world
}

#Install using the convenience script
#Docker provides a convenience script at get.docker.com to install Docker into development environments quickly and non-interactively
{
    curl -fsSL https://get.docker.com -o get-docker.sh
    DRY_RUN=1 sh ./get-docker.sh
}

#Uninstalling docker
{
    sudo yum remove docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
}

#Set insecure registries / Block registries
{
    sudo vi /etc/containers/registries.conf
    {
        [registries.insecure]
        registries = ["reg1.example.com","reg2.example.com"]

        [registries.block]
        registries = ['reg10.example.com']
    }
    sudo systemctl restart docker
}
