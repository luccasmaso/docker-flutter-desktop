#!/bin/bash

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') && echo "My IP is: $ip"
docker run -e DISPLAY=$ip -v /tmp/.X11-unix:/tmp/.X11-unix --privileged flutter-app