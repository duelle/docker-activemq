FROM dockerfile/java:openjdk-7-jre
MAINTAINER Kamil Domański <kamil@domanski.co>

EXPOSE 8161 61616

ENV AMQ_VERSION 5.10.0

RUN useradd activemq && \
    mkdir /opt/apache-activemq-${AMQ_VERSION}/ && \
    chown activemq /opt/apache-activemq-${AMQ_VERSION}/

USER activemq

RUN wget -O - ftp://ftp.mirrorservice.org/sites/ftp.apache.org/activemq/${AMQ_VERSION}/apache-activemq-${AMQ_VERSION}-bin.tar.gz \
    | tar zxf - -C /opt/

ENTRYPOINT ["/bin/sh", "-c", "/opt/apache-activemq-${AMQ_VERSION}/bin/linux-x86-64/wrapper", "wrapper.daemonize=FALSE"]
