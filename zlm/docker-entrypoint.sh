#!/bin/bash
sed -i "s/api-secret/${SECRET}/g" /opt/media/conf/config.ini
exec "$@"