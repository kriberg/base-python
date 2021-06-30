FROM python:3.10.0b3-slim-buster
ARG BUILD_DATE
ARG BUILD_URL
ARG GIT_URL
ARG GIT_COMMIT
ARG VERSION
LABEL maintainer="Kristian Berg <kristian.berg@evry.com>" \
      org.opencontainers.image.title="base-python" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.authors="Kristian Berg <kristian.berg@evry.com>" \
      org.opencontainers.image.url=$BUILD_URL \
      org.opencontainers.image.documentation="https://github.com/evryfs/base-python/" \
      org.opencontainers.image.source=$GIT_URL \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$GIT_COMMIT \
      org.opencontainers.image.vendor="EVRY Financial Services" \
      org.opencontainers.image.licenses="proprietary-license" \
      org.opencontainers.image.description="Base image for python 3"
ENV DEBIAN_FRONTEND=noninteractive LANG=C.UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends libaio1 curl ca-certificates wget vim dnsutils iputils-ping netcat iproute2 net-tools tar gzip bzip2 unzip tzdata lsof psmisc less && \
    apt-get -y clean && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -s https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linuxx64.zip -o /tmp/instantclient-basic-linuxx64.zip && \
    curl -s https://download.oracle.com/otn_software/linux/instantclient/instantclient-sdk-linuxx64.zip -o /tmp/instantclient-sdk-linuxx64.zip && \
    cd /opt && \
    unzip /tmp/instantclient-basic-linuxx64.zip && \
    unzip /tmp/instantclient-sdk-linuxx64.zip && \
    rm /tmp/*.zip && \
    mv instantclient* instantclient
RUN echo /opt/instantclient > /etc/ld.so.conf.d/oracle-instantclient.conf && ldconfig
COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt
RUN python -V
RUN pip freeze
RUN useradd -r -s /bin/bash -c "application user" -d /app -u 1001 -g 100 -m appuser
RUN echo 'PATH="/app/.local/bin:$PATH"' >> /app/.bashrc
WORKDIR /app
USER 1001:100
CMD ["python"]
