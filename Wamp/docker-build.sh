#!/bin/bash

docker build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t efremropelato/wamp:1.0.0 .

# docker run --rm -p 9000:9000 efremropelato/wamp:1.0.0 --ws 0.0.0.0:9000 --realm txt
# docker run -d --name wamp-test --restart always -e TZ=Europe/Rome -p 9000:9000 efremropelato/wamp:1.0.0 --ws 0.0.0.0:9000 --realm txt