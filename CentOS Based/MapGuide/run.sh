# docker volume create -d local-persist \
# -o mountpoint=/opt/mapguide/3.1.2/Repositories/ \
# --name=mapguide_3.1.2_repositories



docker run -d \
-p 8008:8008 \
-p 8009:8009 \
-p 2810:2810 \
-p 2811:2811 \
-p 2812:2812 \
-v mapguide_3.1.2_repositories:/usr/local/mapguideopensource-3.1.2/server/Repositories:rw \
--restart always \
--name mapguide_3.1.2 efremropelato/mapguide:centos-3.1.2
