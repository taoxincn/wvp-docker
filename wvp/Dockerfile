FROM ubuntu:20.04 AS build

ARG gitUrl="https://gitee.com/pan648540858"

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends openjdk-11-jdk git maven nodejs npm ca-certificates && \
    apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt/wvp/config /opt/wvp/heapdump

RUN cd /home && \
    git clone "${gitUrl}/maven.git" && \
    cp maven/settings.xml /usr/share/maven/conf/

RUN cd /home && \
    git clone "${gitUrl}/wvp-GB28181-pro.git"

RUN cd /home/wvp-GB28181-pro/web_src && \
    npm install && \
    npm run build

RUN cd /home/wvp-GB28181-pro && \
    mvn clean package -Dmaven.test.skip=true && \
    cp /home/wvp-GB28181-pro/target/*.jar /opt/wvp/

COPY application.yml /opt/wvp/config/application.yml

RUN cd /opt/wvp && \
    echo '#!/bin/bash' > run.sh && \
    echo 'cd /opt/wvp' >> run.sh && \
    echo 'java ${WVP_JVM_CONFIG} -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/opt/wvp/heapdump/ -jar *.jar --spring.config.location=/opt/wvp/config/application.yml ${WVP_CONFIG}' >> run.sh && \
    chmod +x run.sh

FROM ubuntu:20.04

EXPOSE 5060/tcp
EXPOSE 5060/udp
EXPOSE 18080/tcp

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends tzdata openjdk-11-jre ca-certificates language-pack-zh-hans && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ENV LC_ALL=zh_CN.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    mkdir -p /opt/media/bin/www

COPY --from=build /opt /opt
WORKDIR /opt/wvp
CMD ["sh", "run.sh"]