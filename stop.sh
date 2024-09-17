#!/bin/bash

# stop & remove the containers and delete the images
docker compose down
docker compose rm --force

# Ensure all containers are stopped and removed
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

# Force remove all images
docker rmi -f $(docker images -q)

# delete the cache and the indices
rm -rf elasticsearch/data/_state
rm -rf elasticsearch/data/indices
rm -rf elasticsearch/data/snapshot_cache
rm -rf elasticsearch/data/node.lock
rm -rf elasticsearch/data/nodes
