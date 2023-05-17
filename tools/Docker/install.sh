#Install the repository
{
    sudo apt-get update

    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
}
#Add Docker’s official GPG key
{
    sudo mkdir -p /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
}

#Set up the repository
{
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
}

#Install docker-engine
{
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

#Manage Docker as a non-root user
{
    #Create the docker group
    sudo groupadd docker
    #Add user to docker group
    sudo usermod -aG docker $USER
}

#Configure Docker to start on boot
{
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}

#Configure where the Docker daemon listens for connections
{
    #Configuring remote access with systemd unit file
    {
        sudo systemctl edit docker.service
        #Modify these lines
        {
            [Service]
            ExecStart=
            ExecStart=/usr/bin/dockerd -H fd:// -H tcp://127.0.0.1:2375
        }
        sudo systemctl daemon-reload
        sudo systemctl restart docker.service
        sudo netstat -lntp | grep dockerd
    }
    #Configuring remote access with daemon.json
    {
        nano /etc/docker/daemon.json
        #Set the hosts array to connect to the UNIX socket and an IP address, as follows:
        {
            "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]
        }
        sudo systemctl daemon-reload
        sudo systemctl restart docker.service
        sudo netstat -lntp | grep dockerd
    }
}

#Unistall docker
{
    sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
}

#---Troubleshooting---

#Kernel compatibility
{
    curl https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh >check-config.sh
    bash ./check-config.sh
}

#Cannot connect to the Docker daemon
{
    env | grep DOCKER_HOST

    #To unset host
    unset DOCKER_HOST
}

#IP forwarding problems
{
    nano /usr/lib/systemd/network/
    #Edit the file <interface>.network
    {
        [Network]
        ...
        IPForward=kernel
        # OR
        IPForward=true
    }
}
#Specify DNS servers for docker
{
    sudo nano /etc/docker/daemon.json
    {
        {
            "dns": ["8.8.8.8", "8.8.4.4"]
        }
    }
    sudo service docker restart
}

#Disable dnsmasq
{
    #Ubuntu
    {
        sudo nano /etc/NetworkManager/NetworkManager.conf
        #Comment out the dns=dnsmasq line
        [
            # dns=dnsmasq 
        ]
        sudo systemctl restart network-manager
        sudo systemctl restart docker
    }
    #RHEL, CentOS, or Fedora
    {
        #Disable the dnsmasq service
        sudo systemctl stop dnsmasq
        sudo systemctl disable dnsmasq

        #Configure the DNS servers manually
    }
}