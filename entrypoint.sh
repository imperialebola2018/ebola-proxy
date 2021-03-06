#!/usr/bin/env bash
set -e

if [ "$#" -eq 2 ]; then
    port=$1
    host=$2
else
    echo "Usage: PORT HOSTNAME"
    echo "e.g. docker run ... 443 ebola2018.dide.ic.ac.uk"
    exit -1
fi

echo "Will listen on port $port with hostname $host"
sed -e "s/_PORT_/$port/g" \
    -e "s/_HOST_/$host/g" \
    /etc/nginx/conf.d/ebola2018.conf.template > /etc/nginx/conf.d/ebola2018.conf

root="/etc/ebola2018/proxy"
mkdir -p $root

a="$root/certificate.pem"
b="$root/ssl_key.pem"

echo "Waiting for SSL certificate files at:"
echo "- $a"
echo "- $b"

while [ ! -e $a ]
do
    sleep 2
done

while [ ! -e $b ]
do
    sleep 2
done

echo "Certificate files detected. Running nginx"
exec nginx -g "daemon off;"
