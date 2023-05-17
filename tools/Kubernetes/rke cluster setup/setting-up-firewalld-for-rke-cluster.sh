{
    sudo apt update
    sudo apt upgrade
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
}
{
    sudo firewall-cmd --permanent --new-zone=docker
    sudo firewall-cmd --permanent --zone=public --add-service=http
    sudo firewall-cmd --permanent --zone=public --add-service=https
    sudo firewall-cmd --set-default-zone=public
    sudo firewall-cmd --permanent --zone=trusted --add-port=4243/tcp
    sudo firewall-cmd --zone=public --add-masquerade --permanent
    sudo firewall-cmd --permanent --zone=docker --change-interface=docker0
    sudo firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 4 -i docker0 -j ACCEPT
    sudo systemctl restart firewalld
    sudo firewall-cmd --reload
}
{
    for i in 22 80 443 179 5473 6443 8472 2376 8472 2379-2380 9099 10250 10251 10252 10254 30000-32767; do
        sudo firewall-cmd --add-port=${i}/tcp --permanent
    done
    for i in 8285 8472 4789 30000-32767; do
        sudo firewall-cmd --add-port=${i}/udp --permanent
    done
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-ports
    sudo systemctl restart docker
    sudo systemctl status docker
}
