#!/usr/bin/env sh
set -e

if [ $# -lt 1 ]; then
  echo "Usage: build.sh <maven-version> (push)?"
  exit 1
fi

PUSH=
if [ "$(printf '%s' "${2}" | tr '[:upper:]' '[:lower:]')" = "push" ]; then
  PUSH=--push
  echo "Pushing images to Docker Hub"
else
  echo "Building images only"
fi

REPO_NAME=infotechsoft/maven
MAVEN_VERSION="$1"
MAJOR_VERSION=$(echo "$MAVEN_VERSION" | cut -d . -f 1)
JAVA_VERSIONS="${JAVA_VERSIONS:-8 11 17 21 25}"

for JAVA_VERSION in $JAVA_VERSIONS; do
  BASE_TAG="jdk-$JAVA_VERSION"
  BASE_IMAGE="infotechsoft/java:$JAVA_VERSION"

  echo "Building Maven ${MAVEN_VERSION} on ${BASE_TAG}"
  docker build \
    --build-arg BASE_IMAGE="$BASE_IMAGE" \
    --build-arg MAVEN_VERSION="$MAVEN_VERSION" \
    --pull \
    ${PUSH:+"$PUSH"} \
    --tag "$REPO_NAME:$MAVEN_VERSION-$BASE_TAG" \
    --tag "$REPO_NAME:$MAJOR_VERSION-$BASE_TAG" \
    --provenance=true \
    --sbom=true \
    .
    
  if docker scout >/dev/null 2>&1 ; then
    echo "Generating CVE report for $REPO_NAME:$MAJOR_VERSION-$BASE_TAG"
    docker scout cves --format markdown "$REPO_NAME:$MAJOR_VERSION-$BASE_TAG" > reports/maven-$MAJOR_VERSION-$BASE_TAG-cves.md
  else
    echo "Docker scout not installed, skipping CVE report..."
  fi
done
