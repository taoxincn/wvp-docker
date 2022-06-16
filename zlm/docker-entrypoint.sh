#!/bin/bash
sed -i "s/api-secret/${SECRET}/g" /opt/media/conf/config.ini
sed -i "s/DefaultMediaServer/${SERVERID}/g" /opt/media/conf/config.ini
sed -i "s/8088/${PORT}/g" /opt/media/conf/config.ini
exec "$@"