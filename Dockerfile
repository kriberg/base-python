FROM evryfs/docker-baseimage
RUN apt-get update && \
	apt-get -y install python python3 && \
	apt-get -y clean && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
