#!/usr/bin/env bash

#---------------------------------
# Install HAproxy
#---------------------------------

sudo apt-get install haproxy

#---------------------------------
# Enable HAproxy
#---------------------------------

sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/haproxy
 
#---------------------------------
# Rename orignal configuration file
#---------------------------------
    
mv /etc/haproxy/haproxy.cfg{,.original}

#---------------------------------
# New file configuration
#---------------------------------

PROXY1=$(cat <<EOF
global
    log 127.0.0.1 local0 notice
    maxconn 2000
    user haproxy
    group haproxy

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    retries 3
    option redispatch
    timeout connect  5000
    timeout client  10000
    timeout server  10000

listen proxy1 0.0.0.0:80
    mode http
    stats enable
    stats uri /haproxy?stats
    stats realm Strictly\ Private
    stats auth A_Username:YourPassword
    stats auth Another_User:passwd
    balance roundrobin
    option httpclose
    option forwardfor
    server web1 192.168.50.102:80 check
    server web2 192.168.50.103:80 check
EOF
)
echo "${PROXY1}" > /etc/haproxy/haproxy.cfg

#----------------------------------
# Start service
#----------------------------------

service haproxy start

