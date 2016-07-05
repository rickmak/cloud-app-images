FROM quay.io/skygeario/cloud-app-deps:latest
MAINTAINER Skygear.io <hello@skygear.io>

ARG SKYGEAR_SERVER_VERSION=0.13.0
ARG SKYGEAR_SERVER_SHA256=c1f8ad5771d69a61b4cc386c0a5880a32c92efe2962b5e8165064f5844c30cc8
ARG CLOUDCODE_RUNTIME_VERSION=0.13.0
ARG CLOUDCODE_RUNTIME_SHA256=1be8391c81add9e5a54280cb3d9acb5f2eb78b354946b4418e856a8d526848ad

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
