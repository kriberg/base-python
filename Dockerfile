FROM evryfs/docker-baseimage
RUN apt-get update && \
	apt-get -y --no-install-recommends install python3 python-pip && \
	apt-get -y clean && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	useradd -c "application user" -d /app -s /bin/bash -m app -u 99 --system
WORKDIR /app
USER app
ENTRYPOINT ["python"]
