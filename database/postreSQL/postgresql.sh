#Installing PostgreSQL
{
    sudo apt update
    sudo apt install postgresql postgresql-contrib
    sudo systemctl start postgresql.service
}

#Using PostgreSQL Roles and Databases
{
    sudo -i -u postgres psql
    \q
}

#Creating a New Role
{
    createuser --interactive

    sudo -u postgres createuser --interactive
    man createuser
}

Creating a New Database
{
    createdb sammy

    sudo -u postgres createdb sammy
}

#Opening a Postgres Prompt with the New Role
{
    sudo adduser sammy
    sudo -i -u sammy psql
    sudo -i -u sammy psql -d postgres
    $sammy=#\conninfo
}

#Creating and Deleting Tables
{
    CREATE TABLE table_name (
    column_name1 col_type (field_length) column_constraints,
    column_name2 col_type (field_length),
    column_name3 col_type (field_length)
);

    CREATE TABLE playground (
    equip_id serial PRIMARY KEY,
    type varchar (50) NOT NULL,
    color varchar (25) NOT NULL,
    location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')),
    install_date date
    );

    \d
    [Output
                  List of relations
 Schema |          Name           |   Type   | Owner 
--------+-------------------------+----------+-------
 public | playground              | table    | sammy
 public | playground_equip_id_seq | sequence | sammy
(2 rows)]
}

#Adding, Querying, and Deleting Data in a Table
{
    INSERT INTO playground (type, color, location, install_date) VALUES ('slide', 'blue', 'south', '2017-04-28');
    INSERT INTO playground (type, color, location, install_date) VALUES ('swing', 'yellow', 'northwest', '2018-08-16');
    SELECT * FROM playground;
        [
            Output
        equip_id | type  | color  | location  | install_date 
        ----------+-------+--------+-----------+--------------
                1 | slide | blue   | south     | 2017-04-28
                2 | swing | yellow | northwest | 2018-08-16
        (2 rows)
        ]
    DELETE FROM playground WHERE type = 'slide';
}
