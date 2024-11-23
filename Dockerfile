# ------- BUILD LAYER --------- #
FROM alpine AS build

ARG mc_version
ENV MC_VERSION=${mc_version}

RUN apk add --no-cache curl jq

COPY --chmod=755 install-paper.sh /tmp/install-paper.sh
RUN /tmp/install-paper.sh

# -------- APP LAYER ---------- #
FROM amazoncorretto:21

ENV PUID 1000
RUN yum install wget shadow-utils -y && useradd -r -u ${PUID} mc

ENV GOSU_VERSION 1.17
COPY --chmod=755 install-gosu.sh /tmp/install-gosu.sh
RUN /tmp/install-gosu.sh

COPY --from=build --chmod=755 /tmp/server.jar /opt/minecraft/server.jar

# https://docs.papermc.io/paper/aikars-flags
ENV JAVA_FLAGS="-Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=mcflags.emc.gs -Dcom.mojang.eula.agree=true"
ENV PAPERMC_FLAGS="--nojline"
ENV MEM_SIZE="1G"

WORKDIR /data

COPY --chmod=755 docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD java -jar -Xms${MEM_SIZE} -Xmx${MEM_SIZE} ${JAVA_FLAGS} /opt/minecraft/server.jar ${PAPERMC_FLAGS} nogui
