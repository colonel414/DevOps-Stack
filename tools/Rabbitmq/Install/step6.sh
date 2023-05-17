#RabbitMQ User Management Commands
{
    #1;- Delete User:
    rabbitmqctl delete_user user
    #2;- Change User Password:
    rabbitmqctl change_password user strongpassword
    #3;- Create new Virtualhost:
    rabbitmqctl add_vhost /my_vhost
    #4;- List available Virtualhosts:
    rabbitmqctl list_vhosts
    #5;- Delete a virtualhost:
    rabbitmqctl delete_vhost /myvhost
    #6;- Grant user permissions for vhost:
    rabbitmqctl set_permissions -p /myvhost user ".*" ".*" ".*"
    #7;- List vhost permissions:
    rabbitmqctl list_permissions -p /myvhost
    #8;- To list user permissions:
    rabbitmqctl list_user_permissions user
    #9;- Delete user permissions:
    rabbitmqctl clear_permissions -p /myvhost user
}

#Centos
{
    
}
