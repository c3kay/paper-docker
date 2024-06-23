# ------- BUILD LAYER --------- #
FROM alpine AS build
ARG mc="1.20"

RUN apk add curl jq

COPY dl-stable-paper.sh /tmp/dl-stable-paper.sh
RUN MINECRAFT_VERSION=${mc} /bin/sh /tmp/dl-stable-paper.sh

# -------- APP LAYER ---------- #
FROM amazoncorretto:21

RUN yum install shadow-utils -y && useradd -r mc
USER mc

WORKDIR /data
VOLUME /data

COPY --from=build --chmod=755 --chown=mc /tmp/server.jar /opt/minecraft/server.jar

# https://docs.papermc.io/paper/aikars-flags
ENV JAVA_FLAGS="-Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=mcflags.emc.gs -Dcom.mojang.eula.agree=true"
ENV PAPERMC_FLAGS="--nojline"
ENV MEMORYSIZE="1G"

EXPOSE 25565/tcp
EXPOSE 25565/udp

ENTRYPOINT java -jar -Xms${MEMORYSIZE} -Xmx${MEMORYSIZE} ${JAVA_FLAGS} /opt/minecraft/server.jar ${PAPERMC_FLAGS} nogui
