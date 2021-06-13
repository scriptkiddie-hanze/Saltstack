#!/bin/bash

HOSTNAME=$(hostname)
IPADDRESS=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

cat > /tmp/config.cfg << EOF

define host {
        use                   linux-server
        host_name             $HOSTNAME
        alias                 Server $HOSTNAME
        address               $IPADDRESS
        max_check_attempts    5
        check_period          24x7
        notification_interval 30
        notification_period   24x7
}

EOF
