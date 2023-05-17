#Install RabbitMQ Server 
{
    $ sudo apt update
    $ sudo apt install rabbitmq-server
    $ systemctl status rabbitmq-server.service
    $ systemctl is-enabled rabbitmq-server.service
    $ sudo systemctl enable rabbitmq-server
}

#Centos
{
    sudo yum makecache -y --disablerepo='*' --enablerepo='rabbitmq_rabbitmq-server'
    sudo yum -y install rabbitmq-server
    rpm -qi rabbitmq-server 

    #Start RABBITMQ Service
    echo "127.0.0.1 $(hostname -s)" | sudo tee -a /etc/hosts
    sudo systemctl enable --now rabbitmq-server.service
    systemctl status rabbitmq-server.service 
    sudo rabbitmqctl status 
}