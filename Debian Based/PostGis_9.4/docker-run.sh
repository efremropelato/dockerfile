#! /bin/bash

# docker volume create postgis94_data

docker run -d -p 5432:5432 --restart always \
	-v postgis94_data:/var/lib/postgresql/data:rw \
	--restart always \
	-e POSTGRES_PASSWORD=postgres \
	-e POSTGRES_USER=postgres \
	--name PostGis94 efremropelato/postgis:9.4
