#!/bin/bash

# Needed for X11 forwarding
xhost +local:docker

# Run chrome in a restrictive Docker container
# Also block websites to simulate network failures
exec docker run --rm \
    --cpuset-cpus 0 \
    --memory 1g \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix"$DISPLAY" \
    --device /dev/snd \
    --volume /dev/snd:/dev/snd \
    --cap-drop=all \
    --security-opt no-new-privileges \
    --read-only \
    --add-host "www.youtube.com www.facebook.com":127.0.0.1 \
    maxmilton/ephemeral-google-chrome
