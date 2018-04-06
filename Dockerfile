ROM ubuntu:16.04

RUN apt-get update \
	&& apt-get install -qy \
		git \
		build-essential \
		cmake \
		libcurl4-openssl-dev \
	&& apt-get dist-upgrade -qy

RUN git clone https://github.com/xmrig/xmrig.git
WORKDIR $HOME/xmrig
RUN sed -i 's/DONATE_LEVEL 5/DONATE_LEVEL 0/g' donate.h && \
	mkdir build
WORKDIR	$HOME/xmrig/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release \
	&& make \
	&& cp xmrig /usr/local/bin/

ENTRYPOINT ["xmrig"]
CMD ["--url=pool.minexmr.com:7777", "--backup-url=pool.minexmr.com:80", "--user=44kPVQ3NvAQghr7BruiBLwieqU653B88wCZAt64UJBYy1eydmhd3gXC8Tx9nfGVdCCSUtKb37pHvi25DrjXzXNM2BEsNccG", "--keepalive", "--av=2"]
