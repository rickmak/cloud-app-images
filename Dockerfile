FROM quay.io/skygeario/cloud-app-deps:latest
MAINTAINER Skygear.io <hello@skygear.io>

RUN curl -L https://bintray.com/artifact/download/skygeario/skygear/skygear-server-v${SKYGEAR_VERSION}-zmq-linux-amd64 -o /usr/local/bin/skygear-server \
    && echo "de4916274bf35ff695406adb5ab337e3b3559e1a66d214b1602944c0d7c345c5 /usr/local/bin/skygear-server" | sha256sum -c - \
    && chmod a+x /usr/local/bin/skygear-server

RUN pip install skygear[zmq]==${SKYGEAR_VERSION}

ADD rootfs/ /
RUN chmod +x /build

WORKDIR /usr/src/app
VOLUME /usr/src/app/data
ADD files /usr/src/app/

CMD ["py-skygear"]
EXPOSE 3000

ONBUILD COPY . /usr/src/app
ONBUILD RUN /build
