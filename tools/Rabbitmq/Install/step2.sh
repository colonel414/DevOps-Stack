#Add RabbitMQ Repository to Ubuntu
{
    curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.deb.sh | sudo bash
}

#Add packegeCloud YUM Repository
{
    
    sudo yum -y update
    curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
}