FROM ubuntu
MAINTAINER stan.wong

RUN apt-get update
RUN apt-get install -y build-essential subversion libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev unzip libmbedtls-dev git-core wget ccache libmbedtls-dev

RUN mkdir /openwrt
RUN cd /openwrt && wget "https://downloads.openwrt.org/chaos_calmer/15.05.1/brcm47xx/generic/OpenWrt-SDK-15.05.1-brcm47xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2"
RUN cd /openwrt && tar xjf  "OpenWrt-SDK-15.05.1-brcm47xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2"

WORKDIR /openwrt/OpenWrt-SDK-15.05.1-brcm47xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64

RUN ls /openwrt/

RUN ./scripts/feeds update packages && ./scripts/feeds install libpcre

RUN git clone https://github.com/ovh/overthebox-shadowsocks-libev.git package/shadowsocks-libev
RUN git clone https://github.com/tuapuikia/shadowsocks-openwrt.git /tmp/
RUN cp -R /tmp/shadowsocks-openwrt/mbedtls package/.

RUN make V=99 package/shadowsocks-libev/openwrt/compile
