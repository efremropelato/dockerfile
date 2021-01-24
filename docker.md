# Install Plug-in
## Local Persist Volume Plugin for Docker

```sh
curl -fsSL https://raw.githubusercontent.com/MatchbookLab/local-persist/master/scripts/install.sh | sudo bash
```

# Container
## Mongo DB

```sh
docker volume create mongo_4
docker volume create mongo_4_config
docker run --name mongo_4 -v mongo_4:/data/db -v mongo_4_config:/data/configdb -d -p 27017:27017 mongo:4.2.6

docker volume create mongo_3
docker volume create mongo_3_config
docker run --name mongo_3 -v mongo_3:/data/db -v mongo_3_config:/data/configdb -d -p 27017:27017 mongo:3.2
```

> @home

```sh
docker volume create -d local-persist -o mountpoint=/opt/mongo/data_4/ --name=mongo_4
docker volume create -d local-persist -o mountpoint=/opt/mongo/config_4/ --name=mongo_4_config

docker run --name mongo_4 --restart always \
-v mongo_4:/data/db -v mongo_4_config:/data/configdb -d -p 27017:27017 mongo:4.2.6
```

> @Swarm Example

```sh
docker volume create mongo_4
docker volume create mongo_4_config

docker service create \
  --mount type=volume,src=mongo_4,dst=/data/db \
  --mount type=volume,src=mongo_4_config,dst=/data/configdb \
  --replicas 2 \
  -p 27017:27017 \
  --name mongo_4 \
  mongo:4.2.6
```

> @ Stage 105

```sh
docker volume create -d local-persist -o mountpoint=/opt/mongo/data_4/ --name=mongo_4
docker volume create -d local-persist -o mountpoint=/opt/mongo/config_4/ --name=mongo_4_config

docker run --name mongo_4 --restart always \
-v mongo_4:/data/db -v mongo_4_config:/data/configdb -d -p 27017:27017 mongo:4.2.8

```



## Timescale PostGis

```sh
docker volume create timescale_postgis
docker run -d -p 5432:5432 -v timescale_postgis:/var/lib/postgresql/data:rw \
	-e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres \
	--name timescaleGis timescale/timescaledb-postgis:latest-pg10 postgres
```

> @home
```sh
docker volume create -d local-persist -o mountpoint=/opt/timescale/ts10/ --name=ts10_data
docker run -d -p 5432:5432 --restart always \
	-v ts10_data:/var/lib/postgresql/data:rw \
	--restart always -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres \
	--name timescaleGis10 timescale/timescaledb-postgis:latest-pg10 postgres
	
docker run -d -p 5433:5432 --restart always \
	-v tsdb9_data:/var/lib/postgresql/data:rw \
	--restart always -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres \
	--name TimescaleGis9 timescale/timescaledb-postgis:latest-pg9.6 postgres
```
---

> @Stage

```sh
docker volume create db_geoweb
docker run -d -p 5433:5432 --restart always \ 
	-v db_geoweb:/var/lib/postgresql/data:rw \
	--restart always -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres \
	--name GeoWeb-data timescale/timescaledb-postgis:latest-pg10 postgres
```

> timescale/timescaledb-postgis:1.3.1-pg11 for platform

> @Stage 105

```sh
docker volume create -d local-persist -o mountpoint=/opt/timescaledb_gis/10/ --name=tsdb10_data

docker volume create -d local-persist -o mountpoint=/opt/timescaledb_gis/9.6/ --name=tsdb96_data

docker volume create -d local-persist -o mountpoint=/opt/timescaledb_gis/9.4/ --name=tsdb94_data

docker run -d -p 5433:5432 --restart always \
	-v tsdb10_data:/var/lib/postgresql/data:rw \
	--restart always -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres \
	--name TimescaleGis10 timescale/timescaledb-postgis:latest-pg10 postgres
	
docker run -d -p 5434:5432 --restart always \
	-v tsdb96_data:/var/lib/postgresql/data:rw \
	--restart always -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres \
	--name TimescaleGis96 timescale/timescaledb-postgis:latest-pg9.6 postgres
		
docker run -d -p 5432:5432 --restart always \
	-v tsdb94_data:/var/lib/postgresql/data:rw \
	--restart always \
	-e POSTGRES_PASSWORD=postgres \
	-e POSTGRES_USER=postgres \
	--name PostGis94 postgres:9.4.26

# exec apt install postgis postgres-9.4-postgis postgres-9.4-postgis-script
```

# Dgraph

> @home

```sh
docker volume create dgraph_data

docker run -d \
-p 6080:6080 \
-p 8080:8080 \
-p 9080:9080 \
-p 8000:8000 \
--restart always \
-v dgraph_data:/dgraph \
--name Dgraph dgraph/standalone

```



# PGHero

> @home

```sh
docker run -d \
--link=PostgreSQL \
-e DATABASE_URL=postgres://postgres:postgres@PostgreSQL:5432/GW_ANSALDO \
--name PGHero-GW_ANSALDO \
-p 8090:8080 ankane/pghero

```

> @Stage

```sh
docker run -d \
--link=GeoWeb-data \
-e DATABASE_URL=postgres://postgres:postgres@GeoWeb-data:5432/GW_ANSALDO \
--name PGHero-GW_ANSALDO \
-p 8090:8080 ankane/pghero
```

# MapGuide

```sh
docker volume create -d local-persist -o mountpoint=/opt/mapguide/3.1.2/Repositories/ --name=mapguide_3.1.2_repositories

docker run -d \
-p 8008:8008 \
-p 8009:8009 \
-p 2810:2810 \
-p 2811:2811 \
-p 2812:2812 \
-v mapguide_3.1.2_repositories:/usr/local/mapguideopensource-3.1.2/server/Repositories:rw \
--restart always \
--name mapguide_3.1.2 efremropelato/mapguide:3.1.2

docker run -d --net=host --name mapguide_3.1.2 efremropelato/mapguide:3.1.2

docker run -d \
-p 8008:8008 \
-p 8009:8009 \
-p 2810:2810 \
-p 2811:2811 \
-p 2812:2812 \
-v mapguide_3.1.2_repositories:/usr/local/mapguideopensource-3.1.2/server/Repositories:rw \
--restart always \
--name mapguide_3.1.2 efremropelato/mapguide:centos-3.1.2
```

# KeyCloak

```sh
docker volume create -d local-persist -o mountpoint=/opt/keycloak/themes/ --name=keycloak_themes

docker run -d \
	--name keycloak \
	--restart always \
	--link=PostgreSQL \
	-p 8088:8080 \
	-e PROXY_ADDRESS_FORWARDING=true \
	-e KEYCLOAK_USER=ropeadmin \
	-e KEYCLOAK_PASSWORD=<<password>> \
	-e DB_VENDOR=postgres \
	-e DB_ADDR=PostgreSQL \
	-e DB_PORT=5432 \
	-e DB_DATABASE=keycloak \
	-e DB_USER=postgres \
	-e DB_PASSWORD=postgres \
	-v keycloak_themes:/opt/jboss/keycloak/themes:rw  \
	jboss/keycloak
```

> ```sh
> # after run
> docker exec keycloak /opt/jboss/keycloak/bin/add-user-keycloak.sh -u ropeadmin -p <<password>>
> ```

## OwnCloud

```sh
docker volume create -d local-persist -o mountpoint=/opt/owncloud/html/ --name=owncloud_html
docker volume create -d local-persist -o mountpoint=/opt/owncloud/apps/ --name=owncloud_apps
docker volume create -d local-persist -o mountpoint=/opt/owncloud/config/ --name=owncloud_config
docker volume create -d local-persist -o mountpoint=/opt/owncloud/data/ --name=owncloud_data


docker run -d -p 8888:80 \
	-v owncloud_html:/var/www/html:rw \
	-v owncloud_apps:/var/www/html/custom_apps:rw \
	-v owncloud_config:/var/www/html/config:rw \
	-v owncloud_data:/var/www/html/data:rw \
	--link=PostgreSQL \
	-e POSTGRES_HOST=PostgreSQL -e POSTGRES_USER=owncloud \
	-e POSTGRES_DB=owncloud -e POSTGRES_PASSWORD=owncloud \
	--restart always \
	--name Owncloud owncloud/server:10.4.1
	
```

## NextCloud

```sh
docker volume create -d local-persist -o mountpoint=/opt/nextcloud/html/ --name=nextcloud_html
docker volume create -d local-persist -o mountpoint=/opt/nextcloud/apps/ --name=nextcloud_apps
docker volume create -d local-persist -o mountpoint=/opt/nextcloud/config/ --name=nextcloud_config
docker volume create -d local-persist -o mountpoint=/opt/nextcloud/data/ --name=nextcloud_data


docker run -d -p 8080:80 \
	-v nextcloud_html:/var/www/html:rw \
	-v nextcloud_apps:/var/www/html/custom_apps:rw \
	-v nextcloud_config:/var/www/html/config:rw \
	-v nextcloud_data:/var/www/html/data:rw \
	-v /opt/nextcloud/php/php.ini-development:/usr/local/etc/php/php.ini-development:rw \
	-v /opt/nextcloud/php/php.ini-production:/usr/local/etc/php/php.ini-production:rw \
	-v /opt/nextcloud/php/conf.d:/usr/local/etc/php/conf.d:rw \
	--link=PostgreSQL \
	-e POSTGRES_HOST=PostgreSQL -e POSTGRES_USER=nextcloud \
	-e POSTGRES_DB=nextcloud -e POSTGRES_PASSWORD=nextcloud \
	--restart always \
	--name NextCloud nextcloud:apache
	
```

## Redis

### in-memory

```sh
docker run -d \
	--restart always \
	-p 6379:6379 \
	--name redis redis:alpine
```
### data persistent

```sh
docker volume create redis_data

docker run -d \
	--restart always \
	-p 6379:6379 \
	-v redis_data:/data \
	--name redis redis:alpine
```

@Stage
```sh
docker volume create -d local-persist -o mountpoint=/opt/redis/data/ --name=redis_data

docker run -d \
	--restart always \
	-p 6379:6379 \
	-v redis_data:/data \
	--name redis redis:alpine
```

## Mosquitto

``` sh
docker volume create mosquitto_data
docker volume create mosquitto_log
docker volume create mosquitto_conf

docker run -d \
	--restart always \
	-p 1883:1883 \
	-p 9001:9001 \
	-v mosquitto_conf:/mosquitto/config \
	-v mosquitto_data:/mosquitto/data \
	-v mosquitto_log:/mosquitto/log \
	--name mosquitto eclipse-mosquitto
```

 @home
``` sh
docker volume create -d local-persist -o mountpoint=/opt/mosquitto/data/ --name=mosquitto_data
docker volume create -d local-persist -o mountpoint=/opt/mosquitto/log/ --name=mosquitto_log
docker volume create -d local-persist -o mountpoint=/opt/mosquitto/conf/ --name=mosquitto_conf

docker run -d \
	--restart always \
	-p 1883:1883 \
	-p 9001:9001 \
	-v mosquitto_conf:/mosquitto/config \
	-v mosquitto_data:/mosquitto/data \
	-v mosquitto_log:/mosquitto/log \
	--name mosquitto_bim eclipse-mosquitto
```

 @Stage
``` sh
docker volume create -d local-persist -o mountpoint=/opt/mosquitto/data/ --name=mosquitto_data
docker volume create -d local-persist -o mountpoint=/opt/mosquitto/log/ --name=mosquitto_log
docker volume create -d local-persist -o mountpoint=/opt/mosquitto/conf/ --name=mosquitto_conf

docker run -d \
	--restart always \
	-p 1883:1883 \
	-p 9001:9001 \
	-v mosquitto_conf:/mosquitto/config \
	-v mosquitto_data:/mosquitto/data \
	-v mosquitto_log:/mosquitto/log \
	--name mosquitto_bim eclipse-mosquitto
```

## Scylla DB

``` sh
docker volume create scylla_data
docker volume create scylla_config

docker run -d \
  --restart always \
  -p 9042:9042 \
  -p 9160:9160 \
  -p 10000:10000 \
  -p 9180:9180 \
  -v scylla_data:/var/lib/scylla \
  -v $(pwd)/scylla.yaml:/etc/scylla/scylla.yaml \
  --name="scylla" \
  scylladb/scylla:4.1.8 --smp 2 --memory 2G --overprovisioned 1
```
## Scylla DB Manager

``` sh
docker run -d \
  --restart always \
  -p 56080:56080 \
  -p 56443:56443 \
  -p 56090:56090 \
  -p 56112:56112 \
  --name="scylla-manager" \
  scylladb/scylla-manager
```


## MiniDLNA

```sh
docker run -d \
  --net=host \
  -v /home/eropelato/Musica:/media/audio \
  -v /home/eropelato/Video:/media/video \
  -v /home/eropelato/Immagini:/media/photo \
  -e MINIDLNA_MEDIA_DIR_1=A,/media/audio \
  -e MINIDLNA_MEDIA_DIR_2=V,/media/video \
  -e MINIDLNA_MEDIA_DIR_3=P,/media/photo \
  -e MINIDLNA_FRIENDLY_NAME=RopeDLNA \
  --name RopeDLNA \
  vladgh/minidlna
```

> @home

```sh
docker volume create -d local-persist -o mountpoint=/opt/minidlna/audio/ --name=minidlna-audio
docker volume create -d local-persist -o mountpoint=/opt/minidlna/video/ --name=minidlna-video
docker volume create -d local-persist -o mountpoint=/opt/minidlna/movie/ --name=minidlna-movie
docker volume create -d local-persist -o mountpoint=/opt/minidlna/photo/ --name=minidlna-photo

docker run -d \
  --net=host \
  --restart always \
  -v minidlna-audio:/media/audio \
  -v minidlna-video:/media/video \
  -v minidlna-movie:/media/movie \
  -v minidlna-photo:/media/photo \
  -e MINIDLNA_MEDIA_DIR_1=A,/media/audio \
  -e MINIDLNA_MEDIA_DIR_2=V,/media/video \
  -e MINIDLNA_MEDIA_DIR_3=V,/media/movie \
  -e MINIDLNA_MEDIA_DIR_4=P,/media/photo \
  -e MINIDLNA_FRIENDLY_NAME=RopeDLNA \
  --name RopeDLNA \
  vladgh/minidlna
```
> TODO: add port: es. 
> ```
> -p 8200:8200/tcp \
> -p 1900:1900/udp \
> 
> sudo ufw allow from 192.168.0.0/24 to any port 8200/tcp
> sudo ufw allow from 127.0.0.0/24 to any port 8200/tcp
> sudo ufw allow from 192.168.0.0/24 to any port 1900/udp
> sudo ufw allow from 127.0.0.0/24 to any port 1900/udp
> 
> # or
> 
> sudo iptables -A INPUT -p tcp --dport 8200 -s 192.168.0.0/24 -j ACCEPT
> sudo iptables -A INPUT -p tcp --dport 8200 -s 127.0.0.0/8 -j ACCEPT
> sudo iptables -A INPUT -p tcp --dport 8200 -j DROP
> sudo iptables -A INPUT -p udp --dport 1900 -s 192.168.0.0/24 -j ACCEPT
> sudo iptables -A INPUT -p udp --dport 1900 -s 127.0.0.0/8 -j ACCEPT
> sudo iptables -A INPUT -p udp --dport 1900 -j DROP
> ```


## Plex

```sh
docker volume create -d local-persist -o mountpoint=/home/eropelato/plex/config/ --name=plex-config
docker volume create -d local-persist -o mountpoint=/home/eropelato/plex/transcode/ --name=plex-transcode
docker volume create -d local-persist -o mountpoint=/home/eropelato/plex/data/ --name=plex-data


docker run \
-d \
--name Plex \
-p 32400:32400/tcp \
-p 3005:3005/tcp \
-p 8324:8324/tcp \
-p 32469:32469/tcp \
-p 1900:1900/udp \
-p 32410:32410/udp \
-p 32412:32412/udp \
-p 32413:32413/udp \
-p 32414:32414/udp \
-e TZ="Europe/Rome" \
-e ADVERTISE_IP="http://192.168.0.11:32400/" \
-h "HomeServer" \
-v plex-config:/config \
-v plex-transcode:/transcode \
-v plex-data:/data \
plexinc/pms-docker
```



## Veso.tv

```sh
docker volume create -d local-persist -o mountpoint=/opt/veso/config/ --name=veso-config
docker volume create -d local-persist -o mountpoint=/opt/veso/cache/ --name=veso-cache
docker volume create -d local-persist -o mountpoint=/opt/veso/media/ --name=veso-media

docker run \
-d \
--name Veso \
-v veso-config:/config \
-v veso-cache:/cache \
-v veso-media:/media \
--user 1000:1000 \
--net=host \
--restart always \
vesotv/veso
```
> TODO: add port: es. 
> ```
> -p 8096:8096 \
> -p 8920:8920  \
> -p 1900:1900/udp \
> -p 32410:32410/udp \
> -p 32412:32412/udp \
> -p 32413:32413/udp \
> -p 32414:32414/udp \
> ```



# OpenHub

```sh
sudo groupadd -g 9001 openhab
sudo useradd -g 9001 openhab
sudo usermod -a -G openhab eropelato

sudo mkdir -p /opt/openhab/conf
sudo mkdir -p /opt/openhab/userdata
sudo mkdir -p /opt/openhab/addons
sudo chown -R openhab:openhab /opt/openhab

docker volume create -d local-persist -o mountpoint=/opt/openhab/addons/ --name=openhab_addons
docker volume create -d local-persist -o mountpoint=/opt/openhab/conf/ --name=openhab_conf
docker volume create -d local-persist -o mountpoint=/opt/openhab/userdata/ --name=openhab_userdata

docker run \
        --name openhab \
        -p 8081:8080 \
        -p 8443:8443 \
        -p 8101:8101 \
        -p 5007:5007 \
        --tty \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/timezone:/etc/timezone:ro \
        -v openhab_addons:/openhab/addons \
        -v openhab_conf:/openhab/conf \
        -v openhab_userdata:/openhab/userdata \
        -d \
        --restart=always \
        openhab/openhab:2.5.4
```

> --net=host \



# Portainer.io

```sh
docker volume create -d local-persist -o mountpoint=/opt/portainer/data/ --name=portainer_data

docker run -d \
	-p 8000:8000 \
	-p 9000:9000 \
	--name=portainer \
	--restart=always \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v portainer_data:/data \
	portainer/portainer
```

# Trilium

```sh
docker volume create -d local-persist -o mountpoint=/opt/trilium/data/ --name=trilium-data

docker run -d \
	-p 8888:8080 \
	-v trilium-data:/root/trilium-data \
	--name=trilium \
	--restart=always \
	zadam/trilium:latest
```

