#!/usr/bin/env bash
# https://github.com/tianon/gosu/blob/master/INSTALL.md
set -e

rpmArch="$(rpm --query --queryformat='%{ARCH}' rpm)";
case "$rpmArch" in 
  aarch64) dpkgArch='arm64' ;; 
  armv[67]*) dpkgArch='armhf' ;; 
  i[3456]86) dpkgArch='i386' ;; 
  ppc64le) dpkgArch='ppc64el' ;; 
  riscv64 | s390x) dpkgArch="$rpmArch" ;; 
  x86_64) dpkgArch='amd64' ;; 
  *) echo >&2 "error: unknown/unsupported architecture '$rpmArch'"; exit 1 ;; 
esac;
echo "$rpmArch -> $dpkgArch"

curl -fLo /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch";
chmod +x /usr/local/bin/gosu;

gosu --version; 
gosu nobody true
