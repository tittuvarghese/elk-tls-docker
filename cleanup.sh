docker rm -f $(docker ps -aq)
docker volume prune -f