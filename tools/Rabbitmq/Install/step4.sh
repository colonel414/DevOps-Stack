#Enable the RabbitMQ Management Dashboard (Optional)
{
    $ sudo rabbitmq-plugins enable rabbitmq_management

    $ sudo ss -tunelp | grep 15672

    #If you have an active UFW firewall, open both ports 5672 and 15672:-
    $ sudo ufw allow proto tcp from any to any port 5672,15672

    #To be able to login on the network, create an admin user like below:-
    $ sudo rabbitmqctl add_user admin StrongPassword
    $ sudo rabbitmqctl set_user_tags admin administrator
}

#Centos
{
    sudo rabbitmq-plugins enable rabbitmq_management

    ss -tunelp | grep 15672

    #If you have an active UFW firewall, open both ports 5672 and 15672:-
    sudo firewall-cmd --add-port={5672,15672}/tcp --permanent
    sudo firewall-cmd --reload

    #To be able to login on the network, create an admin user like below:-
    $ sudo rabbitmqctl add_user admin StrongPassword
    $ sudo rabbitmqctl set_user_tags admin administrator
}