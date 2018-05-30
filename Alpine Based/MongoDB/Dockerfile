FROM efremropelato/alpine:3.7_64


RUN set -x \
  && apk update && apk upgrade \
  && apk add --no-cache mongodb \
  && apk add htop nano bash \
  && rm /usr/bin/mongoperf
  
WORKDIR /  

VOLUME /data/db
VOLUME /data/configdb
EXPOSE 27017 28017

CMD mongod --bind_ip 0.0.0.0
