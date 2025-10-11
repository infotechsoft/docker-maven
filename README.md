InfotechSoft Maven/Java Images
========================

This repository contains `Dockerfiles` for running and building Java applications on Rocky Linux within docker containers using Apache Maven.


| Maven | Java | Image | Reports |
| --- | --- | --- | -- |
| 3.9.11 | jdk-25 | [infotechsoft/maven:3-jdk-25](https://hub.docker.com/repository/docker/infotechsoft/maven/tags/3-jdk-25) | [CVES](./reports/maven-3-java-25-cves.md) |
| 3.9.11 | jdk-21 | [infotechsoft/maven:3-jdk-21](https://hub.docker.com/repository/docker/infotechsoft/maven/tags/3-jdk-21) | [CVES](./reports/maven-3-java-21-cves.md) |
| 3.9.11 | jdk-17 | [infotechsoft/maven:3-jdk-17](https://hub.docker.com/repository/docker/infotechsoft/maven/tags/3-jdk-17) | [CVES](./reports/jmaven-3-ava-17-cves.md) |
| 3.9.11 | jdk-11 | [infotechsoft/maven:3-jdk-11](https://hub.docker.com/repository/docker/infotechsoft/maven/tags/3-jdk-11) | [CVES](./reports/maven-3-java-11-cves.md) |
| 3.9.11 | jdk-8  | [infotechsoft/maven:3-jdk-8](https://hub.docker.com/repository/docker/infotechsoft/maven/tags/3-jdk-8) | [CVES](./reports/maven-3-java-8-cves.md) |

## How to Use

### As build environment

```
docker run -it --rm --name mvn-build -v "$(pwd)":/tmp -w /tmp maven:3-jdk-11 mvn clean package
```

## Change History
* 2025-10-11 Updated for Maven 3.9.11 on latest infotechsoft/java
* 2025-05-13 Updated for Maven 3.9.9 on latest infotechsoft/java
