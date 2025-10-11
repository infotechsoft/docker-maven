#!/usr/bin/env bash
set -e
if [ $# -lt 1 ]; then
  echo "Usage: build.sh <mave-version> (push)?"
  exit 1
fi
PUSH=
if [[ "${2,,}" == "push" ]]; then
  PUSH=--push
  echo "Pushing images to Docker Hub"
else
  echo "Building images only"
fi

REPO_NAME=infotechsoft/maven
MAVEN_VERSION=$1
MAJOR_VERSION=$(echo $MAVEN_VERSION | cut -d . -f 1)

BASE_IMAGES="$(< base-images.txt)"
for BASE_IMAGE in $BASE_IMAGES; do
  BASE_TAG=jdk-$(echo $BASE_IMAGE | cut -d ':' -f 2)

  echo "Building Maven ${MAVEN_VERSION} on ${BASE_TAG}"
  docker build \
    --build-arg BASE_IMAGE=$BASE_IMAGE \
    --build-arg MAVEN_VERSION=$MAVEN_VERSION \
    ${PUSH} \
    --tag $REPO_NAME:$MAVEN_VERSION-$BASE_TAG \
    --tag $REPO_NAME:$MAJOR_VERSION-$BASE_TAG \
    --provenance=true \
    --sbom=true \
    .
    
  echo "Generating CVE report for $REPO_NAME:$MAJOR_VERSION-$BASE_TAG"
  docker scout cves --format markdown $REPO_NAME:$MAJOR_VERSION-$BASE_TAG > reports/maven-$MAJOR_VERSION-$BASE_TAG-cves.md
done
