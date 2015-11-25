FROM hearstat/alpine-java:openjdk7

MAINTAINER Hearst Automation Team <atat@hearst.com>

ENV TOMCAT_VERSION 7.0.65

# SET CATALINE_HOME and PATH
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

RUN mkdir -p $CATALINA_HOME
RUN addgroup tomcat && \
    adduser -h $CATALINA_HOME -D -s /bin/bash -G tomcat tomcat

RUN curl \
  --silent \
  --location \
  --retry 3 \
  --cacert /etc/ssl/certs/ca-certificates.crt \
  "https://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && mv /usr/apache-tomcat* $CATALINA_HOME

VOLUME $CATALINA_HOME/webapps

EXPOSE 8080
