#!/bin/bash

OBSCONFIG="/etc/sysconfig/obs-server"

# Pick all environment variables starting with OBS_ and set them in
# /etc/sysconfig/obs-server
for KV in `printenv | grep OBS_`; do
  KEY=`echo ${KV} | cut -d '=' -f1`
  VALUE=`echo ${KV} | cut -d '=' -f2`
  grep -q "^${KEY}" $OBSCONFIG
  if [ $? -eq 0 ]; then
    sed -i "s/${KEY}=.*/${KEY}="${VALUE}"/" $OBSCONFIG
  else
    echo ${KEY}="${VALUE}" >> $OBSCONFIG
  fi
done

mkdir -p /var/cache/obs/worker
mount -t tmpfs -o mode=1777,size=4g none /var/cache/obs/worker

if [ $? -ne 0 ]; then
  echo "Mounting tmpfs was unsuccessful. Image not started in privileged mode?"
  exit 1
fi

/etc/init.d/obsworker start
while [ $? -eq 0 ]; do
  sleep 10
  /etc/init.d/obsworker status
done
