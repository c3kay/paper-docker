#!/usr/bin/env sh
set -e

# https://docs.papermc.io/misc/downloads-api
: "${MC_VERSION:=$(curl -s 'https://api.papermc.io/v2/projects/paper' | jq -r '.versions[-1]')}"
: "${BUILD:=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds" | jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')}"

if [ "$BUILD" != "null" ]; then
    JAR_NAME="paper-${MC_VERSION}-${BUILD}.jar"
    PAPERMC_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${BUILD}/downloads/${JAR_NAME}"
    echo "$PAPERMC_URL"
    curl -o /opt/minecraft/server.jar "$PAPERMC_URL"
else
    echo "No stable build for version ${MC_VERSION} found!"
    exit 1
fi
