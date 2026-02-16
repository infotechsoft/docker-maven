# Docker file for Rocky with JDK and Maven
ARG BASE_IMAGE=infotechsoft/java:25

FROM ${BASE_IMAGE} AS install

ARG MAVEN_VERSION=

RUN dnf -y install gpg && \
  apache_install maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz maven/KEYS

FROM ${BASE_IMAGE}

LABEL maintainer="Thomas J. Taylor <thomas@infotechsoft.com>"

ARG MAVEN_VERSION=
ENV MAVEN_VERSION=${MAVEN_VERSION}
ENV MAVEN_HOME=/opt/apache-maven-${MAVEN_VERSION}
ENV M2_HOME=${MAVEN_HOME}

COPY --from=install ${MAVEN_HOME} ${MAVEN_HOME}
RUN ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin/mvn
