FROM quay.io/skygeario/cloud-app-deps:latest
MAINTAINER Skygear.io <hello@skygear.io>

ARG SKYGEAR_SERVER_VERSION=0.14.0
ARG SKYGEAR_SERVER_SHA256=9a4bd2ff650af42f664f761defae747e5cd40cef38398b634a91b769975ce9a3
ARG CLOUDCODE_RUNTIME_VERSION=0.14.0
ARG CLOUDCODE_RUNTIME_SHA256=df85d1ece776e39b8132629c7e000d42cfd4d59138493f13f99129b2dfc5e627

ENV SKYGEAR_SERVER_VERSION=${SKYGEAR_SERVER_VERSION} \
    CLOUDCODE_RUNTIME_VERSION=${CLOUDCODE_RUNTIME_VERSION}

LABEL \
    io.skygear.cloud-app.server-version=$SKYGEAR_SERVER_VERSION \
    io.skygear.cloud-app.cloudcode-runtime-version=$CLOUDCODE_RUNTIME_VERSION

RUN FILENAME=skygear-server-v${SKYGEAR_SERVER_VERSION}-zmq-linux-amd64 \
    && curl -L https://dl.bintray.com/skygeario/skygear/${FILENAME} -O \
    && echo "${SKYGEAR_SERVER_SHA256} ${FILENAME}" | sha256sum -c - \
    && mv ${FILENAME} /usr/local/bin/skygear-server \
    && chmod a+x /usr/local/bin/skygear-server

RUN FILENAME=skygear-${CLOUDCODE_RUNTIME_VERSION}-py3-none-any.whl \
    && curl -L https://dl.bintray.com/skygeario/skygear/${FILENAME} -O \
    && echo "${CLOUDCODE_RUNTIME_SHA256} ${FILENAME}" | sha256sum -c - \
    && pip install skygear-${CLOUDCODE_RUNTIME_VERSION}-py3-none-any.whl[zmq] \
    && rm skygear-${CLOUDCODE_RUNTIME_VERSION}-py3-none-any.whl

ADD rootfs/ /
RUN chmod +x /build

WORKDIR /usr/src/app
VOLUME /usr/src/app/data

CMD ["/boot"]
EXPOSE 3000
