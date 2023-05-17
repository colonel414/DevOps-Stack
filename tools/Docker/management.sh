#
{
    docker kill --all
    docker image prune
    docker container prune
}
{
    docker image ls
    docker ps
}