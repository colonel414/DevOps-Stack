#Configuring remote access with *systemd* unit file
{
    sudo systemctl edit docker.service
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
    sudo nano /etc/docker/daemon.json
    {
        "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]
    }
    sudo netstat -lntp | grep dockerd
}

#Error:- #Kernel compatibility
{
    curl https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh >check-config.sh
    bash ./check-config.sh
    #The script only works on Linux, not macOS
}

#Error:- Cannot connect to the Docker daemon. Is 'docker daemon' running on this host?
{
    env | grep DOCKER_HOST
    unset DOCKER_HOST
}

#Error:- IP forwarding problems
{
    #To work around this on RHEL, CentOS, or Fedora, edit the <interface>.network file in /usr/lib/systemd/network/ on your Docker host
    sudo nano /usr/lib/systemd/network/80-container-host0.network
    {
        [Network]
        ...
        IPForward=kernel
        # OR
        IPForward=true
    }
    #This configuration allows IP forwarding from the container as expected
}

#Error:- DNS resolver found in resolv.conf and containers can't use it
{
    sudo nano /etc/resolv.conf
    ps aux |grep dnsmasq
}
#Specify DNS servers for Docker
{
     sudo nano /etc/docker/daemon.json
     {
        "dns": ["8.8.8.8", "8.8.4.4"]
     }
     sudo service docker restart

     #Verify that Docker containers can resolve an internal hostname by pinging it
     docker run --rm -it alpine ping -c4 <my_internal_host>
}
#Disable dnsmasq
