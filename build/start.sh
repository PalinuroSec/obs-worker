#!/bin/bash

#use https
sed -i 's/http\:\/\//https\:\/\//g' /usr/sbin/obsworker

#get variables from environment
printenv | grep OBS_ >> /etc/sysconfig/obs-server

mkdir -p /var/cache/obs/worker
mount -t tmpfs -o mode=1777 none /var/cache/obs/worker

if [ $? -ne 0 ]; then
  echo "Mounting tmpfs was unsuccessful. Image not started in privileged mode?"
  exit 1
fi

obsworker start
while [ $? -eq 0 ]; do
  sleep 10
  obsworker status
done
