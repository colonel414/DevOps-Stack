#Set RabbitMQ Cluster (Optional)
{
    https://computingforgeeks.com/how-to-configure-rabbitmq-cluster-on-ubuntu/

}

#To usse rabbitmqadmin commandline tool, copy it to your $PATH
{
    sudo updatedb
    sudo cp locate rabbitmqadmin /usr/local/bin/rabbitmqadmin
    sudo chmod +x /usr/local/bin/rabbitmqadmin
}

#You need to have python installed and configured to run rabbitmqadmin, see below
{
    https://computingforgeeks.com/how-to-install-python-3-python-2-7-on-rhel-8/
}