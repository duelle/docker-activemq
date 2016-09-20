FROM java:openjdk-8-jre
# Original MAINTAINER Kamil Domański <kamil@domanski.co>

EXPOSE 1883 5672 8161 61613 61614 61616

ENV AMQ_VERSION 5.12.0

ADD env.add /

RUN useradd activemq && \
    mkdir /opt/apache-activemq-${AMQ_VERSION}/data/kahadb -p && \
    wget -O - https://archive.apache.org/dist/activemq/${AMQ_VERSION}/apache-activemq-${AMQ_VERSION}-bin.tar.gz  \
    | tar zxf - -C /opt/ && \
    mv /opt/apache-activemq-${AMQ_VERSION}/ /opt/apache-activemq/ && \
    chown activemq -R /opt/apache-activemq

RUN echo '' >>/opt/apache-activemq/bin/env
RUN cat /env.add >>/opt/apache-activemq/bin/env

VOLUME /opt/apache-activemq/data/kahadb

USER activemq

#ENTRYPOINT ["/bin/sh", "-c", "/opt/apache-activemq/bin/activemq console"]
