#Set up Linux Nodes
{
    #Root Login
    {
        ssh root@SERVER_IP_ADDRESS
    }
    #Create a New User
    {
        adduser demo
        passwd demo
    }
    #Granting Administrative Privileges
    {
        usermod -aG wheel demo
    }
    #Setting Up a Basic Firewall
    {
        dnf install firewalld -y
        systemctl start firewalld
        systemctl status firewalld
        firewall-cmd --permanent --list-all         # list which services are already allowed
        firewall-cmd --get-services                 #To see the additional services that you can enable by name
        firewall-cmd --permanent --add-service=http # To add a service that should be allowed, use the --add-service flag
        firewall-cmd --reload                       #reload the firewall
    }
    #Enabling External Access for Your Regular User
    {
        rsync --archive --chown=demo:demo ~/.ssh /home/demo
    }
}

#Set up the Load Balancer (Setting up an NGINX Load Balancer)
{
    #Install NGINX
    {

    }
    #Create NGINX Configuration
    {

    }
}

#Set up the DNS Record
{

}

#Set up a Private Docker Registry
