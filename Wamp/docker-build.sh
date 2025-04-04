#!/bin/bash

docker build -t efremropelato/wamp:1.0.0 .


# docker run efremropelato/wamp:1.0.0 --ws 0.0.0.0:9000 --realm txt