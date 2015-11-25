FROM hearstat/alpine-java:openjdk7

MAINTAINER Hearst Automation Team <atat@hearst.com>

ENV TOMCAT_VERSION 7.0.8
ENV TOMCAT_URL https://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

RUN apk add --update \
    tar \
    && rm /var/cache/apk/*

# SET CATALINE_HOME and PATH
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

RUN mkdir -p $CATALINA_HOME
RUN addgroup tomcat && \
    adduser -h $CATALINA_HOME -D -s /bin/bash -G tomcat tomcat

WORKDIR $CATALINA_HOME

RUN set -x \
    && curl -fSL "$TOMCAT_URL" -o tomcat.tar.gz \
    && tar -xvf tomcat.tar.gz --strip-components=1 \
    && rm bin/*.bat \
    && rm tomcat.tar.gz*

VOLUME $CATALINA_HOME/webapps

EXPOSE 8080
