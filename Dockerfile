FROM amazoncorretto:21

ARG mc_version
ENV MC_VERSION=${mc_version}

ENV PUID=1000
ENV GOSU_VERSION=1.17

# https://docs.papermc.io/paper/aikars-flags
ENV JAVA_FLAGS="-Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=mcflags.emc.gs -Dcom.mojang.eula.agree=true"
ENV PAPERMC_FLAGS="--nojline"
ENV MEM_SIZE="1G"

COPY --chmod=755 ./install-gosu.sh ./install-paper.sh ./docker-entrypoint.sh /usr/local/bin/

RUN yum install -y jq && \
    echo "mc:x:${PUID}:${PUID}::/opt/minecraft:/sbin/nologin" >> /etc/passwd && \
    echo "mc:x:${PUID}:" >> /etc/group && \
    mkdir -p /opt/minecraft/data && \
    install-gosu.sh && \
    install-paper.sh

VOLUME /opt/minecraft/data
WORKDIR /opt/minecraft/data

ENTRYPOINT ["docker-entrypoint.sh"]
CMD java -jar -Xms${MEM_SIZE} -Xmx${MEM_SIZE} ${JAVA_FLAGS} /opt/minecraft/server.jar ${PAPERMC_FLAGS} nogui
