#Automate clustering
{
    docker run -d --rm --net rabbits  \
-v ${PWD}/config/rabbit-1/:/config/  \
-e RABBITMQ_CONFIG_FILE=/config/rabbitmq  \
-e RABBITMQ_ERLANG_COOKIE=$HOME/.erlang.cookie  \
--hostname rke-worker1  \
--name rabbit-1  \
-p 8081:15672  \
rabbitmq:3-management 

docker run -d --rm --net rabbits  \
-v ${PWD}/config/rabbit-2/:/config/  \
-e RABBITMQ_CONFIG_FILE=/config/rabbitmq  \
-e RABBITMQ_ERLANG_COOKIE=$HOME/.erlang.cookie  \
--hostname rke-worker2  \
--name rabbit-2  \
-p 8082:15672  \
rabbitmq:3-management

docker run -d --rm --net rabbits  \
-v ${PWD}/config/rabbit-3/:/config/  \
-e RABBITMQ_CONFIG_FILE=/config/rabbitmq  \
-e RABBITMQ_ERLANG_COOKIE=$HOME/.erlang.cookie  \
--hostname rke-worker3  \
--name rabbit-3  \
-p 8083:15672  \
rabbitmq:3-management

#NODE 1 : MANAGEMENT http://hostip:8081
#NODE 2 : MANAGEMENT http://hostip:8082
#NODE 3 : MANAGEMENT http://hostip:8083

# enable federation plugin
docker exec -it rabbit-1 rabbitmq-plugins enable rabbitmq_federation 
docker exec -it rabbit-2 rabbitmq-plugins enable rabbitmq_federation
docker exec -it rabbit-3 rabbitmq-plugins enable rabbitmq_federation

}