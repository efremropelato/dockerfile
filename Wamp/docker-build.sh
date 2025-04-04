#!/bin/bash

docker build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t efremropelato/wamp:1.0.0 .

# docker run efremropelato/wamp:1.0.0 --ws 0.0.0.0:9000 --realm txt