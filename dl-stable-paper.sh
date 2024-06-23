#!/bin/sh
# https://docs.papermc.io/misc/downloads-api
set -eux
LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')
if [ "$LATEST_BUILD" != "null" ]; then
    JAR_NAME=paper-${MINECRAFT_VERSION}-${LATEST_BUILD}.jar
    PAPERMC_URL="https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"
    curl -o /tmp/server.jar $PAPERMC_URL
else
    echo "No stable build for version $MINECRAFT_VERSION found!"
    exit 1
fi