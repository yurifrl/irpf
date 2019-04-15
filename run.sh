#!/usr/bin/env sh

set unamestr $(uname)

if [ "$unamestr" = 'Linux' ]
   xhost +
else if [ "$unamestr" = 'Darwin' ]
   echo '---> http://sourabhbajaj.com/blog/2017/02/07/gui-applications-docker-mac/'
   set IP $(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
   xhost + "$IP"
end

docker run --rm \
  -t $(tty > /dev/null; echo "-i") \
  --net=host \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME/irpf:/root yurifl/irpf
