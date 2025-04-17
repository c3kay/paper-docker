#!/usr/bin/env sh
# https://docs.papermc.io/misc/downloads-api
set -e

get_latest_stable_version() {
  latest_versions=$(curl -fs https://api.papermc.io/v2/projects/paper | jq -r '.versions | reverse[]')

  while IFS= read -r cur_version; do
    has_stable=$(curl -fs "https://api.papermc.io/v2/projects/paper/versions/${cur_version}/builds" | jq '[.builds[] | select(.channel == "default")] | length > 0')

    if [ "$has_stable" = "true" ]; then
      echo "$cur_version"
      return 0
    fi
  done <<< "$latest_versions"

  echo "Error: No stable PaperMC version found." >&2
  return 1
}

version="${MC_VERSION:-$(get_latest_stable_version)}"
build=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${version}/builds" | jq '.builds | .[-1] | .build')
echo "Latest build for MC ${version}: ${build}"

jar_url="https://api.papermc.io/v2/projects/paper/versions/${version}/builds/${build}/downloads/paper-${version}-${build}.jar"
echo "Downloading from: ${jar_url}"
curl -o "/opt/minecraft/server.jar" "$jar_url"
