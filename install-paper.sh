#!/bin/sh
# https://docs.papermc.io/misc/downloads-api
set -eux

# get latest mc version if env var is not set
: "${MC_VERSION:=$(curl -s 'https://api.papermc.io/v2/projects/paper' | jq -r '.versions[-1]')}"

# get latest stable build for mc version
LATEST_BUILD=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds" | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')

if [ "$LATEST_BUILD" != "null" ]; then
    JAR_NAME="paper-${MC_VERSION}-${LATEST_BUILD}.jar"
    PAPERMC_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"
    curl -o /tmp/server.jar "$PAPERMC_URL"
else
    echo "No stable build for version ${MC_VERSION} found!"
    exit 1
fi