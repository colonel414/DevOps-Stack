#Quick most basic installation for testing
{
    #Using docker
    $ docker run --name rabbitmq bitnami/rabbitmq:latest

    #Using docker-compose
    $ curl -sSL https://raw.githubusercontent.com/bitnami/containers/main/bitnami/rabbitmq/docker-compose.yml >docker-compose.yml
    $ docker-compose up -d
}
