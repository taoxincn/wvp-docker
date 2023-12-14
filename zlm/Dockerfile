FROM ubuntu:20.04 AS build
ARG MODEL=Release
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    git \
    ca-certificates \
    build-essential \
    cmake \
    openssl \
    #libsdl-dev libsdl2-dev \
    libmysqlclient-dev \
    libavutil-dev libavcodec-dev libswscale-dev libswresample-dev \
    libsrtp2-dev && \
    apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/media && \
    cd /opt/media && \
    git clone --depth=1 "https://gitee.com/xia-chu/ZLMediaKit.git" && \
    cd ZLMediaKit && \
    git submodule update --init --recursive && \
    mkdir -p build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=${MODEL} .. && \
    make -j8

FROM ubuntu:20.04

ARG MODEL=Release

EXPOSE 8088 8089 1935 554 554/udp 10000 10000/udp 30000-30199 30000-30199/udp 8000/udp 9000

ENV LC_ALL=zh_CN.UTF-8 TZ=Asia/Shanghai

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    ca-certificates openssl tzdata libsrtp2-1 ffmpeg language-pack-zh-hans && \
    apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

COPY --from=build /opt/media/ZLMediaKit/release/linux/${MODEL}/MediaServer /opt/media/ZLMediaKit/default.pem /opt/media/bin/
COPY --from=build /opt/media/ZLMediaKit/www/ /opt/media/bin/www/
COPY config.ini /opt/media/conf/config.ini
COPY docker-entrypoint.sh /opt/media/docker-entrypoint.sh
RUN chmod +x /opt/media/docker-entrypoint.sh

WORKDIR /opt/media
ENTRYPOINT ["/opt/media/docker-entrypoint.sh"]
CMD ["sh","-c","./bin/MediaServer -s ./bin/default.pem -c ./conf/config.ini"]