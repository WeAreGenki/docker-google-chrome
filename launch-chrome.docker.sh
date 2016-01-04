#!/bin/bash

# Needed for X11 forwarding
xhost +local:docker

# Run chrome in a restrictive Docker container
# Also block websites for productivity
exec docker run --rm \
    --cpuset-cpus 0 \
    --memory 1g \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    --device /dev/snd \
    --volume /dev/snd:/dev/snd \
    --cap-drop=all \
    --add-host "www.youtube.com www.facebook.com":127.0.0.1 \
    maxmilton/ephemeral-google-chrome
