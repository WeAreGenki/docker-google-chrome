#!/bin/bash

# Needed for X11 forwarding
xhost +local:docker

# Run chrome in a restrictive Docker container
# Also block websites for productivity
exec docker run -i -t --rm \
    --cpuset-cpus 0 \
    --memory 1g \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    --device /dev/snd \
    --volume /dev/snd:/dev/snd \
    --cap-drop=all \
    --add-host www.youtube.com:127.0.0.1 \
    --add-host "www.xvideos.com www.yuvutu.com www.youporn.com www.redtube.com www.pornhub.com pornfun.com theporndude.com":127.0.0.1 \
    local/chrome
    
# TODO: Remove --volume /dev/snd when --device works as expected
