docker exec -it rabbit-2 rabbitmqctl stop_app
docker exec -it rabbit-2 rabbitmqctl reset
docker exec -it rabbit-2 rabbitmqctl join_cluster rabbit@rke-worker1
docker exec -it rabbit-2 rabbitmqctl start_app
docker exec -it rabbit-2 rabbitmqctl cluster_status

docker exec -it rabbit-3 rabbitmqctl stop_app
docker exec -it rabbit-3 rabbitmqctl reset
docker exec -it rabbit-3 rabbitmqctl join_cluster rabbit@rke-worker1
docker exec -it rabbit-3 rabbitmqctl start_app
docker exec -it rabbit-3 rabbitmqctl cluster_status

docker exec -it rabbit-2 rabbitmqctl stop_app
docker exec -it rabbit-2 rabbitmqctl reset
docker exec -it rabbit-2 rabbitmqctl join_cluster rabbit@docker exec -it rabbit-2 rabbitmqctl stop_app
docker exec -it rabbit-2 rabbitmqctl reset
docker exec -it rabbit-2 rabbitmqctl join_cluster rabbit@rabbit-1
docker exec -it rabbit-2 rabbitmqctl start_app
docker exec -it rabbit-2 rabbitmqctl cluster_status
docker exec -it rabbit-2 rabbitmqctl start_app
docker exec -it rabbit-2 rabbitmqctl cluster_status