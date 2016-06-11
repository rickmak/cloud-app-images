FROM quay.io/skygeario/cloud-app-deps:latest
MAINTAINER Skygear.io <hello@skygear.io>

ARG SKYGEAR_SERVER_VERSION=0.12.1
ARG SKYGEAR_SERVER_SHA256=8d19e29cf0642b599bdbb5e4eebee6bd955b8162f5d9ed6444c6a2436d31cae0
ARG CLOUDCODE_RUNTIME_VERSION=0.12.0
ARG CLOUDCODE_RUNTIME_SHA256=027dab6e6c9be6070180101ff1db2d1e816e4cf46bfd827dbb31d4d296c6a0ed

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

CMD ["py-skygear"]
EXPOSE 3000
