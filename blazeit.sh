#!/bin/bash

echo "Checking if mqStalker image exists..."
mqStalkerImage=$(docker image ls | grep zofos/mq-stalker)

if [ -z "$mqStalkerImage" ]
then
      echo "[-] mq-stalker's image is NOT available"
      echo "[-] Let's build it.."
      docker build -t zofos/mq-stalker .
      echo "[+] mq-stalker's image has been built successfully!"
else
      echo "[+] mq-stalker's image is here.."
fi

echo "[+] Let's run the container and get shell access"

docker run \
    -it \
    --rm \
    --name mqStalker \
    --ipc=host \
    -v $PWD/src:/var/mq-stalker/ \
    -v /dev/mqueue/:/dev/mqueue/ \
    zofos/mq-stalker bash