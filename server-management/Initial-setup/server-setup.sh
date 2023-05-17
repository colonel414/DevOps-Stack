#Login as root
{
    ssh root@your_server_ip
}
#Update systems
{
    sudo yum -y update
    sudo reboot
}
#Create a New User
{
    adduser ronford
    passwd ronford
}
#Grant sudo Privileges to user
{
    gpasswd -a ronford wheel
    usermod -aG wheel ronford #CentOS
    usermod -aG sudo ronford #Linux
}
#Setting Up a Basic Firewall
{
    #Ubuntu 
    #ufw app list
    #ufw allow OpenSSH
    #ufw enable
    #ufw status 
    #CentOS
    dnf install firewalld -y
    systemctl start firewalld
    systemctl status firewalld
    firewall-cmd --permanent --list-all
    firewall-cmd --get-services
    firewall-cmd --permanent --add-service=http
    firewall-cmd --permanent --add-service=https
    firewall-cmd --reload
}
#Enabling External Access for Your Regular User
{
    sudo nano /etc/sudoers.d/ronford ronford  ALL=(ALL:ALL) NOPASSWD: ALL
    rsync --archive --chown=ronford:ronford ~/.ssh /home/ronford
    chown --recursive ronford:ronford .ssh
}
#Configure SSH Daemon
{
    nano /etc/ssh/sshd_config #Disable root login
    systemctl reload sshd
}
#Remove read-only
#Mount and remount files
{
    sudo mount -oremount,rw /
}
#Install docker
{

}