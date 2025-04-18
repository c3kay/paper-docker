#!/usr/bin/env bash
set -e

if [ -n "${PUID}" ] && [ ! "${PUID}" = "$(id -u mc)" ]; then
  echo "UID: $(id -u mc) -> ${PUID}"
  sed -i -E "s/^mc:([^:]*):[0-9]+:[0-9]+:/mc:\1:${PUID}:${PUID}:/" /etc/passwd
  sed -i -E "s/^mc:([^:]*):[0-9]+:/mc:\1:${PUID}:/" /etc/group
fi

chown -R mc /opt/minecraft
exec gosu mc "$@"
