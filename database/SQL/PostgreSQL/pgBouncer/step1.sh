#download and install the corresponding repository from the PostgreSQL site (if you don’t have it in place yet)
{
    wget https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

    rpm -Uvh pgdg-redhat-repo-latest.noarch.rpm

    yum install pgbouncer

    pgbouncer --version
}
