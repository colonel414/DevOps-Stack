#Monitoring and Managing PgBouncer
{
    psql -p [port] -h [host] -U [$userName] pgbouncer #-- To connect directly to PgBouncer to manage or monitor it

    pgbouncer=# SHOW STATS_TOTALS #-- SHOW STATS_TOTALS

    pgbouncer=# SHOW SERVERS

    pgbouncer=# SHOW CLIENTS

    pgbouncer=# SHOW POOLS

    pgbouncer=# RELOAD

    pgbouncer=# PAUSE databaseName

    pgbouncer=# RESUME databaseName
}
