FROM evryfs/docker-baseimage
RUN apt-get update && \
	apt-get -y --no-install-recommends install python python3 python-pip && \
	apt-get -y clean && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
