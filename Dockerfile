FROM debian
MAINTAINER RPIO
LABEL description="dockerized diamondd for running DMD Node"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      curl git build-essential less nano binutils-gold libssl-dev miniupnpc libgmp3-dev \
      ca-certificates wget autoconf automake libtool pkg-config libcurl4-gnutls-dev \
	libjansson-dev uthash-dev libncursesw5-dev libudev-dev libusb-1.0-0-dev \
	libevent-dev libmicrohttpd-dev hidapi && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone git@github.com:luke-jr/bfgminer.git /usr/src/bfgminer
WORKDIR /usr/src/bfgminer
RUN ./autogen.sh && \
./configure && \
make

VOLUME ["/usr/src/bfgminer"]

CMD ["bfgminer -h"]
