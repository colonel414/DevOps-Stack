#Configuring a Basic Firewall
{
    sudo yum install firewalld
    sudo systemctl start firewalld
    sudo firewall-cmd --permanent --add-service=ssh
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --permanent --add-service=smtp
    #sudo firewall-cmd --get-services
    #sudo firewall-cmd --permanent --list-all
    sudo firewall-cmd --reload
    sudo systemctl enable firewalld
}
#Configure Timezones
{
    sudo timedatectl list-timezones
    sudo timedatectl set-timezone region/timezone #eg sudo timedatectl set-timezone Africa/Nairobi
    sudo timedatectl
}
#Configure NTP Synchronization
{
    sudo yum install ntp
    sudo systemctl start ntpd
    sudo systemctl enable ntpd
}
#Create a Swap File
{
    sudo fallocate -l 4G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'
}