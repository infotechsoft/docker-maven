# Docker file for CentOS with OpenJDK and Maven
ARG BASE_IMAGE=infotechsoft/java:openjdk-17

FROM ${BASE_IMAGE}

LABEL maintainer="Thomas J. Taylor <thomas@infotechsoft.com>"

ARG MAVEN_VERSION=

ENV MAVEN_VERSION ${MAVEN_VERSION}
ENV MAVEN_HOME /opt/apache-maven-${MAVEN_VERSION}
ENV M2_HOME ${MAVEN_HOME}

RUN apache_install maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz maven/KEYS \
    && ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin/mvn

CMD ["bash"]
