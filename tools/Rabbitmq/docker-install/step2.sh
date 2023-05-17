#Get this image
{
    #to pull the prebuilt image from the Docker Hub Registry.
    $ docker pull bitnami/rabbitmq:latest

    #To use a specific version
    $ docker pull bitnami/rabbitmq:[TAG]

    #Build the image yourself by cloning the repository
    $ git clone https://github.com/bitnami/containers.git
    $ cd bitnami/APP/VERSION/OPERATING-SYSTEM
    $ docker build -t bitnami/APP:latest
}
