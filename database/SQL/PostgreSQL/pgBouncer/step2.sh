#How to Use PgBouncer
{
    cat /etc/pgbouncer/pgbouncer.ini #--The pgbouncer.ini configuration file

    cat /etc/pgbouncer/userlist.txt #--the authentication file

    pgbouncer -d /etc/pgbouncer/pgbouncer.ini #-- To start the PgBouncer service

    netstat -pltn

    psql -p [port] -h [host] -U [$userName] [$databaseName] #-- To access the PostgreSQL database
}
