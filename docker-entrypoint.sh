#!/bin/sh
set -eux

if [ -n "${PUID}" ] && [ ! "${PUID}" = "$(id mc -u)" ]; then
    usermod -o -u "$PUID" mc
    echo "UID of mc user: $(id mc -u)"
fi
chown -R mc /data
exec gosu mc "$@"
