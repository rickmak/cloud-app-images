FROM alpine:edge
MAINTAINER Skygear.io <hello@skygear.io>

RUN apk --update --no-cache add \
        libc6-compat libstdc++ curl coreutils tar

RUN curl -L https://github.com/just-containers/s6-overlay/releases/download/v1.17.1.1/s6-overlay-amd64.tar.gz -o /tmp/s6-overlay.tar.gz \
    && echo "376fcc089838b8c1e546635a22e823c99739d13f8741d8dba4d70bb51ec175ad /tmp/s6-overlay.tar.gz" | sha256sum -c - \
    && tar xvfz /tmp/s6-overlay.tar.gz -C / \
    && rm -f /tmp/s6-overlay.tar.gz

ENTRYPOINT [ "/init" ]

ENV LIBSODIUM_VERSION=1.0.5 \
    ZMQ_VERSION=4.1.3 \
    CZMQ_VERSION=3.0.2 \
    SKYGEAR_VERSION=0.10.0

RUN apk --update --no-cache add --virtual build-dependencies \
        coreutils gcc libtool make musl-dev openssl-dev g++ zlib-dev \
    && echo " ... adding libsodium" \
        && curl -L https://download.libsodium.org/libsodium/releases/libsodium-${LIBSODIUM_VERSION}.tar.gz -o /tmp/libsodium.tar.gz \
        && cd /tmp/ \
        && echo "bfcafc678c7dac87866c50f9b99aa821750762edcf8e56fc6d13ba0ffbef8bab libsodium.tar.gz" | sha256sum -c - \
        && tar -xf /tmp/libsodium.tar.gz \
        && cd /tmp/libsodium*/ \
        && ./configure --prefix=/usr \
                       --sysconfdir=/etc \
                       --mandir=/usr/share/man \
                       --infodir=/usr/share/info \
        && make && make install \
        && rm -rf /tmp/libsodium* \
        && cd .. \
    && echo " ... adding zeromq" \
        && curl -L http://download.zeromq.org/zeromq-${ZMQ_VERSION}.tar.gz -o /tmp/zeromq.tar.gz \
        && cd /tmp/ \
        && echo "61b31c830db377777e417235a24d3660a4bcc3f40d303ee58df082fcd68bf411 zeromq.tar.gz" | sha256sum -c - \
        && tar -xf /tmp/zeromq.tar.gz \
        && cd /tmp/zeromq*/ \
        && ./configure --prefix=/usr \
                       --sysconfdir=/etc \
                       --mandir=/usr/share/man \
                       --infodir=/usr/share/info \
        && make && make install \
        && rm -rf /tmp/zeromq* \
        && cd .. \
    && echo " ... adding czmq" \
        && curl -L http://download.zeromq.org/czmq-${CZMQ_VERSION}.tar.gz -o /tmp/czmq.tar.gz \
        && cd /tmp/ \
        && echo "8bca39ab69375fa4e981daf87b3feae85384d5b40cef6adbe9d5eb063357699a czmq.tar.gz" | sha256sum -c - \
        && tar -xf /tmp/czmq.tar.gz \
        && cd /tmp/czmq*/ \
        && ./configure --prefix=/usr \
                       --sysconfdir=/etc \
                       --mandir=/usr/share/man \
                       --infodir=/usr/share/info \
        && make && make install \
        && rm -rf /tmp/czmq* \
        && cd .. \
    && apk del build-dependencies \
    && ln -s /lib /lib64

RUN curl -L https://bintray.com/artifact/download/skygeario/skygear/skygear-server-v${SKYGEAR_VERSION}-zmq-linux-amd64 -o /usr/local/bin/skygear-server \
    && echo "de4916274bf35ff695406adb5ab337e3b3559e1a66d214b1602944c0d7c345c5 /usr/local/bin/skygear-server" | sha256sum -c - \
    && chmod a+x /usr/local/bin/skygear-server

RUN apk --update --no-cache add \
        python3 python3-dev postgresql postgresql-dev build-base libffi-dev \
        git subversion bzr mercurial \
    && pip3 install --upgrade pip \
    && pip install skygear[zmq]==${SKYGEAR_VERSION}

ADD rootfs/ /
RUN chmod +x /build

WORKDIR /usr/src/app
VOLUME /usr/src/app/data
ADD files /usr/src/app/

CMD ["py-skygear"]
EXPOSE 3000

ONBUILD COPY . /usr/src/app
ONBUILD RUN /build
