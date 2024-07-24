#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Usage: build_and_push.sh <maven-version>"
  exit 1
fi

REPO_NAME=infotechsoft/maven
MAVEN_VERSION=$1
MAJOR_VERSION=$(echo $MAVEN_VERSION | cut -d . -f 1)

BASE_IMAGES="$(< base-images.txt)"
for BASE_IMAGE in $BASE_IMAGES; do
  BASE_TAG=$(echo $BASE_IMAGE | cut -d ':' -f 2)

  docker build \
    --build-arg BASE_IMAGE=$BASE_IMAGE \
    --build-arg MAVEN_VERSION=$MAVEN_VERSION \
    -t $REPO_NAME:$BASE_TAG -t $REPO_NAME:$MAVEN_VERSION-$BASE_TAG -t $REPO_NAME:$MAJOR_VERSION-$BASE_TAG \
    .

  docker push $REPO_NAME:$BASE_TAG
  docker push $REPO_NAME:$MAVEN_VERSION-$BASE_TAG
  docker push $REPO_NAME:$MAJOR_VERSION-$BASE_TAG
done
