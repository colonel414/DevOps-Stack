https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-20-04

#Configuring the Primary Database to Accept Connections
{
    sudo nano /etc/postgresql/12/main/postgresql.conf
    [listen_addresses = 'your_primary_IP_address']

}

#Creating a Special Role with Replication Permissions
{
    sudo -u postgres psql
    [CREATE ROLE test WITH REPLICATION PASSWORD 'testpassword' LOGIN
    ]
    \q
    sudo nano /etc/postgresql/12/main/pg_hba.conf
    [host replication test your-replica-IP/32 md5]
    sudo systemctl restart postgresql@12-main
}

#Backing Up the Primary Cluster on the Replica
{
    sudo -u postgres psql
    SHOW data_directory
    sudo -u postgres rm -r /var/lib/postgresql/12/main/*

    #Note: If the command does not work, recreate the main directory with the appropriate permissions
    sudo -u postgres rm -r /var/lib/postgresql/12/main
    sudo -u postgres mkdir /var/lib/postgresql/12/main
    sudo -u postgres chmod 700 /var/lib/postgresql/12/main

    sudo -u postgres pg_basebackup -h primary-ip-addr -p 5432 -U test -D /var/lib/postgresql/12/main/ -Fp -Xs -R
}

#Restarting and Testing the Clusters
{
    sudo systemctl restart postgresql@12-main
    sudo -u postgres psql
    SELECT client_addr, state FROM pg_stat_replication
    [
    Output
    client_addr | state
    ------------------+-----------
    your_replica_IP | streaming
    ]
}
