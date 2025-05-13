InfotechSoft Maven/Java Images
========================

This repository contains `Dockerfiles` for running and building Java applications on Rocky Linux within docker containers using Apache Maven.

## How to Use

### As build environment

```
docker run -it --rm --name mvn-build -v "$(pwd)":/tmp -w /tmp maven:3-jdk-11 mvn clean package
```

* 2025-05-13 Updated for Maven 3.9.9 on latest infotechsoft/java JDKs
