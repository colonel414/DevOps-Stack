#Persisting your application
{
    $ docker run \
        -v /path/to/rabbitmq-persistence:/bitnami \
        bitnami/rabbitmq:latest

    #With docker-compose
    rabbitmq:
    ...
    volumes:
    - /path/to/rabbitmq-persistence:/bitnami
    ...
}
