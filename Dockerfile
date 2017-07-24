FROM ubuntu
MAINTAINER stan.wong

RUN apt-get update && apt-get install -y apt-utils build-essential subversion libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev unzip libmbedtls-dev git-core wget ccache

RUN mkdir /openwrt
RUN cd /openwrt && wget "https://downloads.openwrt.org/chaos_calmer/15.05.1/brcm47xx/generic/OpenWrt-SDK-15.05.1-brcm47xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2" && tar xjf  "OpenWrt-SDK-15.05.1-brcm47xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2"

WORKDIR /openwrt/OpenWrt-SDK-15.05.1-brcm47xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64

RUN ./scripts/feeds update packages && ./scripts/feeds install libpcre

RUN git clone https://github.com/ovh/overthebox-shadowsocks-libev.git package/shadowsocks-libev && cd package/shadowsocks-libev && git pull

RUN git clone https://github.com/tuapuikia/shadowsocks-openwrt.git /tmp/ && cd /tmp && git pull

RUN cp -R /tmp/mbedtls package/.

RUN make V=99 package/shadowsocks-libev/openwrt/compile
