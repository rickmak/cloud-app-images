FROM quay.io/skygeario/cloud-app-deps:latest
MAINTAINER Skygear.io <hello@skygear.io>

ARG SKYGEAR_SERVER_VERSION=0.10.0
ARG SKYGEAR_SERVER_SHA256=de4916274bf35ff695406adb5ab337e3b3559e1a66d214b1602944c0d7c345c5
ARG CLOUDCODE_RUNTIME_VERSION=0.10.0
ARG CLOUDCODE_RUNTIME_SHA256=34076b60a0567192a12e57a17653c76a96fb55132d8b021c4c98d4ab838c999a

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
ADD files /usr/src/app/

CMD ["py-skygear"]
EXPOSE 3000
