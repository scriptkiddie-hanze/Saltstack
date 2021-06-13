#!/bin/sh

for dir in /var/cache/salt/master/minions/*; do
    cp "$dir"/files/tmp/config.cfg /usr/local/nagios/etc/servers/$(basename "$dir").cfg
done

systemctl restart nagios.service
